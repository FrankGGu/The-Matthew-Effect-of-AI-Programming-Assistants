-module(solution).
-export([find_books_with_no_available_copies/2]).

find_books_with_no_available_copies(Books, Copies) ->
    BooksWithAvailableCopies = lists:foldl(
        fun({_CopyId, BookId, available}, AccSet) ->
                sets:add_element(BookId, AccSet);
           ({_CopyId, _BookId, _Status}, AccSet) ->
                AccSet
        end,
        sets:new(),
        Copies
    ),
    lists:filter(
        fun({BookId, _Title}) ->
                not sets:is_element(BookId, BooksWithAvailableCopies)
        end,
        Books
    ).