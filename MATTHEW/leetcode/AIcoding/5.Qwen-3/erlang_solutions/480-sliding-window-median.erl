-module(slide_window_median).
-export([medianSlidingWindow/2]).

medianSlidingWindow(Nums, K) ->
    N = length(Nums),
    if
        N == 0 -> [];
        true ->
            Sorted = lists:sort(Nums),
            Sliding = lists:seq(0, N - K),
            lists:map(fun(I) -> getMedian(Sorted, I, K) end, Sliding)
    end.

getMedian(Sorted, Start, K) ->
    End = Start + K - 1,
    Mid = Start + K div 2,
    if
        K rem 2 == 0 ->
            (lists:nth(Mid, Sorted) + lists:nth(Mid + 1, Sorted)) / 2;
        true ->
            lists:nth(Mid + 1, Sorted)
    end.