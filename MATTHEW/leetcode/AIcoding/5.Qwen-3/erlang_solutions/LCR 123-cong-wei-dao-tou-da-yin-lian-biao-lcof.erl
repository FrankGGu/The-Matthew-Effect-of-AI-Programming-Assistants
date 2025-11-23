-module(solution).
-export([borrow_book/1]).

borrow_book(Books) ->
    borrow_book(Books, []).

borrow_book([], Acc) ->
    lists:reverse(Acc);
borrow_book([H | T], Acc) ->
    case H of
        0 -> borrow_book(T, [H | Acc]);
        _ -> borrow_book(T, Acc)
    end.