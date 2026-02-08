-module(matching_subsequences).
-export([numMatchingSubseq/2]).

numMatchingSubseq(S, Words) ->
    numMatchingSubseq(S, Words, 0).

numMatchingSubseq(_S, [], Acc) ->
    Acc;
numMatchingSubseq(S, [Word | Rest], Acc) ->
    case isSubsequence(Word, S) of
        true ->
            numMatchingSubseq(S, Rest, Acc + 1);
        false ->
            numMatchingSubseq(S, Rest, Acc)
    end.

isSubsequence([], _T) ->
    true;
isSubsequence(_S, []) ->
    false;
isSubsequence([H | T], [H | T2]) ->
    isSubsequence(T, T2);
isSubsequence([H | T], [_ | T2]) ->
    isSubsequence([H | T], T2).