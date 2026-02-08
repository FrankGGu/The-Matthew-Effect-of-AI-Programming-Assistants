-module(solution).
-export([smallest_range_ii/2]).

-spec smallest_range_ii(A :: [integer()], K :: integer()) -> integer().
smallest_range_ii(A, K) ->
    N = length(A),
    if N =:= 1 ->
        0;
    true ->
        SortedA = lists:sort(A),
        A0 = hd(SortedA),
        ANMinus1 = lists:last(SortedA),

        MinDiff = ANMinus1 - A0,

        lists:foldl(fun({ASplitMinus1, ASplit}, AccMinDiff) ->
                            MinVal = min(A0 + K, ASplit - K),
                            MaxVal = max(ASplitMinus1 + K, ANMinus1 - K),

                            NewDiff = MaxVal - MinVal,
                            min(AccMinDiff, NewDiff)
                    end, MinDiff, lists:zip(SortedA, tl(SortedA)))
    end.