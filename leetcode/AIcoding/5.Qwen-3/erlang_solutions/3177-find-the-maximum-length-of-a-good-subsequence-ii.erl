-module(solution).
-export([longest_subsequence/1]).

longest_subsequence(Sequence) ->
    N = length(Sequence),
    MaxLen = 0,
    DP = array:new(N, {default, 0}),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                J < I andalso abs(Sequence--I - Sequence--J) >= 2 ->
                    array:set(I, max(array:get(I, Acc2), array:get(J, Acc2) + 1), Acc2);
                true ->
                    Acc2
            end
        end, Acc, lists:seq(0, I-1))
    end, DP, lists:seq(0, N-1)),
    array:max(DP).