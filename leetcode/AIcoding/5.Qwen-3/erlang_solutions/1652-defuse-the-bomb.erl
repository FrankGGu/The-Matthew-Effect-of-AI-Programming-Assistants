-module(defuse_the_bomb).
-export([solve/2]).

solve(Numbers, Time) ->
    Len = length(Numbers),
    lists:map(fun(I) -> get_value(Numbers, I, Time, Len) end, lists:seq(0, Len - 1)).

get_value(Numbers, Index, Time, Len) ->
    case Time of
        0 -> 0;
        _ ->
            Sum = lists:foldl(fun(I, Acc) -> Acc + lists:nth(I + 1, Numbers) end, 0, get_indices(Index, Time, Len)),
            Sum
    end.

get_indices(Index, Time, Len) ->
    lists:seq(Index + 1, Index + Time, 1) ++ lists:seq(Index - Time, Index - 1, 1).

get_indices(_, _, _) ->
    [].