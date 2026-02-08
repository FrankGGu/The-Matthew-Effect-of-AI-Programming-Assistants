-module(solution).
-export([num_matching_subseq/1]).

num_matching_subseq(S) ->
    Words = ["a","bb","acd","ace"],
    num_matching_subseq(S, Words, 0).

num_matching_subseq(_, [], Count) -> Count;
num_matching_subseq(S, [Word | Rest], Count) ->
    case is_subsequence(S, Word) of
        true -> num_matching_subseq(S, Rest, Count + 1);
        false -> num_matching_subseq(S, Rest, Count)
    end.

is_subsequence(S, Word) ->
    is_subsequence(S, Word, 0, 0).

is_subsequence(_, _, _, WLen) when WLen =:= length(Word) -> true;
is_subsequence(S, Word, SPos, WPos) when SPos < length(S) ->
    case lists:nth(SPos + 1, S) =:= lists:nth(WPos + 1, Word) of
        true -> is_subsequence(S, Word, SPos + 1, WPos + 1);
        false -> is_subsequence(S, Word, SPos + 1, WPos)
    end;
is_subsequence(_, _, _, _) -> false.