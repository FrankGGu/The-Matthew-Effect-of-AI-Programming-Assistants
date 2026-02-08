-module(palindromic_substrings).
-export([count_substrings/1]).

count_substrings(S) ->
    Len = length(S),
    count_palindromes(S, Len).

count_palindromes(S, Len) ->
    count_palindromes(S, Len, 0, 0).

count_palindromes(S, Len, Index, Count) when Index >= Len ->
    Count;
count_palindromes(S, Len, Index, Count) ->
    Count1 = count_palindromes_from_center(S, Len, Index, Index, Count),
    Count2 = count_palindromes_from_center(S, Len, Index, Index + 1, Count1),
    count_palindromes(S, Len, Index + 1, Count2).

count_palindromes_from_center(S, Len, Left, Right, Count) when Left < 0 orelse Right >= Len ->
    Count;
count_palindromes_from_center(S, Len, Left, Right, Count) ->
    case lists:nth(Left + 1, S) == lists:nth(Right + 1, S) of
        true ->
            count_palindromes_from_center(S, Len, Left - 1, Right + 1, Count + 1);
        false ->
            Count
    end.