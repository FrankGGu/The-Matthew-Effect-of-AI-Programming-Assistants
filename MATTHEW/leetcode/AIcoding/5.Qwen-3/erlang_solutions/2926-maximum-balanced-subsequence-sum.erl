-module(maximum_balanced_subsequence_sum).
-export([maxBalancedSubsequence/1]).

maxBalancedSubsequence(Numbers) ->
    N = length(Numbers),
    Sorted = lists:sort([{Index, Num} || {Index, Num} <- lists:zip(lists:seq(0, N-1), Numbers)]),
    DP = array:new(N, {default, 0}),
    MaxSum = 0,
    lists:foreach(fun({I, X}) ->
        lists:foreach(fun({J, Y}) ->
            if
                J < I andalso Y < X ->
                    array:set(I, max(array:get(I, DP), array:get(J, DP) + X), DP);
                true -> ok
            end
        end, Sorted)
    end, Sorted),
    lists:max([array:get(I, DP) || I <- lists:seq(0, N-1)]).