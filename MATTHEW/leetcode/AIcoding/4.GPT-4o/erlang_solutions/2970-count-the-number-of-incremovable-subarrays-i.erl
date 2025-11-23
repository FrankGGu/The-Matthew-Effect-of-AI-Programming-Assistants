-module(solution).
-export([count_incremovable_subarray/1]).

count_incremovable_subarray(A) ->
    N = length(A),
    {Left, Right} = count_bounds(A, N),
    MaxLeft = lists:max(Left),
    MinRight = lists:min(Right),
    count_subarrays(A, MaxLeft, MinRight, N).

count_bounds([], _) -> {[], []};
count_bounds([H|T], N) ->
    {Left, Right} = count_bounds(T, N),
    Left1 = [if H > lists:nth1(1, T) -> H; true -> H end | Left],
    Right1 = [if H < lists:nth1(N, T) -> H; true -> H end | Right],
    {Left1, Right1}.

count_subarrays(A, MaxLeft, MinRight, N) ->
    lists:foldl(fun(X, Acc) ->
        if X > MaxLeft andalso X < MinRight -> Acc + 1; true -> Acc end
    end, 0, A).