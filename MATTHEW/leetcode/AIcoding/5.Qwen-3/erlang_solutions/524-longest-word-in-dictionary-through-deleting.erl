-module(longest_word_in_dictionary_through_deleting).
-export([find_longest_word/2]).

find_longest_word(Word, Dictionary) ->
    Sorted = lists:sort(fun(A, B) -> 
        length(A) > length(B) orelse (length(A) == length(B) andalso A =< B)
    end, Dictionary),
    lists:foldl(fun(D, Acc) ->
        case is_subsequence(D, Word) of
            true -> D;
            false -> Acc
        end
    end, "", Sorted).

is_subsequence([], _) -> true;
is_subsequence(_, []) -> false;
is_subsequence([H|T], [H|T2]) -> is_subsequence(T, T2);
is_subsequence([H|T], [_|T2]) -> is_subsequence([H|T], T2).