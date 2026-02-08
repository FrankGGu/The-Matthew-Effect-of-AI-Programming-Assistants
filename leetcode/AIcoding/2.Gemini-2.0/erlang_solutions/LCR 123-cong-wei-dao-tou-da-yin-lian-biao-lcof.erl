-module(book_arrange_i).
-export([arrange_books/1]).

arrange_books(Books) ->
  lists:sort(Books).