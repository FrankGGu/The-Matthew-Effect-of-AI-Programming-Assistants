-module(solution).
-export([find_books/2]).

find_books(Books, Copies) ->
    BookSet = sets:from_list([Book || {Book, _} <- Books]),
    CopySet = sets:from_list([Book || {Book, Available} <- Copies, Available == 0]),
    NoCopies = sets:to_list(sets:subtract(BookSet, CopySet)),
    lists:sort(NoCopies).