-module(max_beauty).
-export([maximum_beauty/2]).

maximum_beauty(Nums, K) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Max = 0,
    {Max, _} = lists:foldl(fun(I, {CurrentMax, Left}) ->
        while Sorted[I] - Sorted[Left] > K do
            Left = Left + 1
        end,
        CurrentMax = max(CurrentMax, I - Left + 1),
        {CurrentMax, Left}
    end, {0, 0}, lists:seq(0, N-1)).