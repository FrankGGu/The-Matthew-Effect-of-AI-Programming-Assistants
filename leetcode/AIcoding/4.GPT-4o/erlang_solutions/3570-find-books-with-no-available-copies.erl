-module(solution).
-export([find_books_no_copies/1]).

find_books_no_copies(Books) ->
    [Book || {Book, Copies} <- Books, Copies =:= 0].