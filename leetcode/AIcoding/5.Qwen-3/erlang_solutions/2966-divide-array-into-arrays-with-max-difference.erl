-module(divide_array_into_arrays_with_max_difference).
-export([high_access/2]).

high_access(Nums, k) ->
    Sorted = lists:sort(Nums),
    high_access(Sorted, k, []).

high_access([], _, Result) ->
    lists:reverse(Result);
high_access([H | T], K, Result) ->
    Group = [H],
    Next = find_next(T, H, K),
    high_access(Next, K, [Group | Result]).

find_next([], _, _) ->
    [];
find_next([H | T], Last, K) ->
    if
        H - Last > K ->
            [H | T];
        true ->
            find_next(T, H, K)
    end.