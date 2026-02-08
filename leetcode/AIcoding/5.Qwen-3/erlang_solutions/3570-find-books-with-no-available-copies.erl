-module(find_books_with_no_available_copies).
-export([findBooksThatAreNotAvailable/1]).

findBooksThatAreNotAvailable(Books) ->
    lists:filter(fun({_, 0}) -> true; (_) -> false end, Books).