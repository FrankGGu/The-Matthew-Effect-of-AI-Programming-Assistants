-module(solution).
-export([shortest_subarray/2]).

shortest_subarray(A, K) ->
    N = length(A),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], A),
    Prefix1 = lists:reverse(Prefix),
    MinQueue = queue:new(),
    shortest_subarray_helper(Prefix1, K, N, MinQueue, infinity).

shortest_subarray_helper([], _, _, MinQueue, Min) -> 
    if Min == infinity -> -1; 
    true -> Min 
    end;
shortest_subarray_helper([H | T], K, N, MinQueue, Min) ->
    {MinQueue1, MinQueue2} = queue:in(H, MinQueue),
    MinLength = case queue:out(MinQueue1) of
        {value, {Val, Q}} when Val + K -> 
            MinLength1 = N - queue:size(Q),
            MinLength2 = shortest_subarray_helper(T, K, N, Q, min(Min, MinLength1)),
            min(MinLength1, MinLength2);
        _ -> 
            shortest_subarray_helper(T, K, N, MinQueue2, Min)
    end,
    MinLength.