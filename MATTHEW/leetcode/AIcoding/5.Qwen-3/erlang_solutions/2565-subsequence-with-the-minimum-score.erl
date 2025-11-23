-module(min_score_subsequence).
-export([minSubsequence/2]).

minSubsequence(S, T) ->
    minSubsequence(S, T, 0, 0, []).

minSubsequence([], _, _, _, Acc) ->
    lists:reverse(Acc);
minSubsequence(_, [], _, _, Acc) ->
    lists:reverse(Acc);
minSubsequence([H|T1], [H|T2], I, J, Acc) ->
    minSubsequence(T1, T2, I+1, J+1, [H|Acc]);
minSubsequence([H|T1], [K|T2], I, J, Acc) ->
    minSubsequence(T1, T2, I+1, J, Acc).