-module(lcs).
-export([longest_common_subsequence/2]).

longest_common_subsequence(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new([{size, N+1}, {default, 0}]),
    longest_common_subsequence(A, B, N, M, DP).

longest_common_subsequence(_, _, 0, _, _) ->
    0;
longest_common_subsequence(_, _, _, 0, _) ->
    0;
longest_common_subsequence(A, B, I, J, DP) ->
    case array:get(I-1, A) == array:get(J-1, B) of
        true ->
            Val = array:get(I-1, DP) + 1,
            array:set(I, Val, DP),
            array:get(I, DP);
        false ->
            Val1 = longest_common_subsequence(A, B, I-1, J, DP),
            Val2 = longest_common_subsequence(A, B, I, J-1, DP),
            Max = max(Val1, Val2),
            array:set(I, Max, DP),
            Max
    end.