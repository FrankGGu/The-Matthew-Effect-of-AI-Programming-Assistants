-module(solution).
-export([find_longest_word/2]).

find_longest_word(S, D) ->
    Words = lists:sort(fun(A, B) -> 
        case length(A) =:= length(B) of
            true -> A =< B;
            false -> length(A) > length(B)
        end
    end, D),
    lists:foldl(fun(Word, Acc) ->
        case is_subsequence(Word, S) of
            true -> Word;
            false -> Acc
        end
    end, "", Words).

is_subsequence([], _) -> true;
is_subsequence(_, []) -> false;
is_subsequence([H|T1], [H|T2]) -> is_subsequence(T1, T2);
is_subsequence(Word, [_|T2]) -> is_subsequence(Word, T2).