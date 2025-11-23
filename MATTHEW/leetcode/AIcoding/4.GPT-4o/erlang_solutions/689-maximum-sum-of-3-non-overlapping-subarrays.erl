-module(solution).
-export([max_sum_of_three_subarrays/2]).

max_sum_of_three_subarrays(S, K) ->
    N = length(S),
    PrefixSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(S)),
    PrefixSumReversed = lists:reverse(PrefixSum),
    {MaxIndices, _} = lists:foldl(fun({i, j}, {Acc, Best}) ->
        if
            j >= K -> 
                NewBest = lists:max([Best, Acc + lists:nth(j + 1, PrefixSumReversed) - lists:nth(j - K + 1, PrefixSumReversed)]),
                {lists:append(Acc, [j - K + 1]), NewBest}
            true -> 
                {Acc, Best}
        end
    end, {[], 0}, lists:zip(lists:seq(0, N - 1), lists:seq(K - 1, N - 1))),

    {Max1, Max2} = lists:foldl(fun(I, {Best1, Best2}) ->
        if
            I >= K -> 
                NewBest1 = lists:max([Best1, lists:nth(I - K + 1, PrefixSumReversed) - lists:nth(I + 1, PrefixSumReversed)]),
                {NewBest1, Best1}
            true -> 
                {Best1, Best2}
        end
    end, {0, 0}, MaxIndices),

    {Max1, Max2}.