-module(solution).
-export([min_subarray_length/2]).

min_subarray_length(Nums, P) ->
    Sum = lists:foldl(fun(X, Acc) -> (Acc + X) rem P end, 0, Nums),
    if
        Sum == 0 -> 0;
        true -> find_min_subarray(Nums, P, Sum, 0, #{0 => -1}, 0)
    end.

find_min_subarray([], _, _, _, _, Min) -> Min;
find_min_subarray([H | T], P, Target, Index, Map, Min) ->
    Current = (Index + H) rem P,
    case maps:is_key(Current, Map) of
        true ->
            Len = Index - maps:get(Current, Map),
            NewMin = if Len < Min -> Len; true -> Min end,
            find_min_subarray(T, P, Target, Index + 1, Map, NewMin);
        false ->
            NewMap = maps:put(Current, Index, Map),
            find_min_subarray(T, P, Target, Index + 1, NewMap, Min)
    end.