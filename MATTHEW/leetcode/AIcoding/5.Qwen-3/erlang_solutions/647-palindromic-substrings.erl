-module(palindromic_substrings).
-export([count_palindromic_substrings/1]).

count_palindromic_substrings(S) ->
    count_palindromic_substrings(S, 0, 0).

count_palindromic_substrings(_, N, Count) when N >= erlang:length(S) ->
    Count;
count_palindromic_substrings(S, N, Count) ->
    Count1 = count_palindromes(S, N, N),
    Count2 = count_palindromes(S, N, N+1),
    count_palindromic_substrings(S, N+1, Count + Count1 + Count2).

count_palindromes(_, L, R) when L < 0 orelse R >= erlang:length(S) ->
    0;
count_palindromes(S, L, R) ->
    if
        erlang:element(L+1, S) == erlang:element(R+1, S) ->
            1 + count_palindromes(S, L-1, R+1);
        true ->
            0
    end.