-module(solution).
-export([can_return_books/2]).

can_return_books(Returns, Books) ->
    can_return_books(Returns, Books, []).

can_return_books([], [], _) -> 
    true;
can_return_books([], _, _) -> 
    false;
can_return_books([H | T], Books, Stack) ->
    case lists:member(H, Books) of
        true ->
            can_return_books(T, Books -- [H], [H | Stack]);
        false ->
            case Stack of
                [] -> false;
                [Top | Rest] when Top == H -> 
                    can_return_books(T, Books, Rest);
                _ -> false
            end
    end.