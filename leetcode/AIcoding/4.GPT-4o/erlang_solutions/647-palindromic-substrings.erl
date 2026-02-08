-module(solution).
-export([count_substrings/1]).

count_substrings(S) ->
    N = string:length(S),
    count_substrings(S, 0, N).

count_substrings(S, Count, N) when N > 0 ->
    Count1 = count_palindromes(S, 0, N - 1) + Count,
    count_substrings(S, Count1, N - 1);
count_substrings(_, Count, _) ->
    Count.

count_palindromes(S, L, R) when L =< R ->
    Count1 = count_single_palindrome(S, L, R),
    Count2 = count_double_palindrome(S, L, R),
    Count1 + Count2.

count_single_palindrome(S, L, R) ->
    case is_palindrome(S, L, R) of
        true -> 1 + count_single_palindrome(S, L, R - 1);
        false -> count_single_palindrome(S, L, R - 1)
    end.

count_double_palindrome(S, L, R) ->
    case is_palindrome(S, L, R + 1) of
        true -> 1 + count_double_palindrome(S, L, R + 1);
        false -> count_double_palindrome(S, L, R + 1)
    end.

is_palindrome(S, L, R) ->
    case L >= R of
        true -> true;
        false -> (string:substr(S, L + 1, 1) =:= string:substr(S, R + 1, 1)) andalso is_palindrome(S, L + 1, R - 1)
    end.