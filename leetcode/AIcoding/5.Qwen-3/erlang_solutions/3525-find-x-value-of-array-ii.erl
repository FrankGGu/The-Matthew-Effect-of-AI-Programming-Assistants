-module(solution).
-export([find_x_value/1]).

find_x_value(Array) ->
    find_x_value(Array, 0, 0).

find_x_value([], _, Acc) ->
    Acc;
find_x_value([H | T], Index, Acc) ->
    Sum = lists:sum(T),
    if
        H == Sum ->
            find_x_value(T, Index + 1, Acc + Index);
        true ->
            find_x_value(T, Index + 1, Acc)
    end.