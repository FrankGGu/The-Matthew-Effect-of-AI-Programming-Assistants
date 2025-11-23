-module(squares_of_sorted_array).
-export([sorted_squares/1]).

sorted_squares(Arr) ->
    lists:map(fun(X) -> X * X end, Arr).

sorted_squares([]) ->
    [];
sorted_squares([H|T]) ->
    [H*H | sorted_squares(T)].