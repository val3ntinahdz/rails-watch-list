class BookmarksController < ApplicationController
  # find the list_id to to create a bookmark inside of it
  before_action :set_list, only: %i[new create]

  # new bookmark
  def new
    @bookmark = Bookmark.new
  end

  # create a bookmark and call the list_id
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :see_other
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
