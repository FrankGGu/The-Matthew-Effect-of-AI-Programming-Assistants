-module(max_coins).
-export([max_coins/1]).

max_coins(Piles) ->
    Sorted = lists:sort(fun(A, B) -> A < B end, Piles),
    max_coins(Sorted, 0, 0).

max_coins([], _, Acc) ->
    Acc;
max_coins([_ | [X | T]], Count, Acc) when Count rem 2 == 0 ->
    max_coins(T, Count + 1, Acc + X);
max_coins([_ | T], Count, Acc) ->
    max_coins(T, Count + 1, Acc).