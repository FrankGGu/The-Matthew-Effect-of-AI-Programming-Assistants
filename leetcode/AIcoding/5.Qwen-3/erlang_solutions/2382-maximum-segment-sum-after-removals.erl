-module(maximum_segment_sum_after_removals).
-export([maxSumAfterRemovals/1]).

maxSumAfterRemovals(A) ->
    N = length(A),
    {_, Sum} = lists:foldl(fun(I, {Parent, Sum}) ->
        Parent2 = maps:put(I, I, Parent),
        Sum2 = Sum + A -- [I],
        {Parent2, Sum2}
    end, {#{}, 0}, lists:seq(1, N)),
    Sum.