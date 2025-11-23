-module(super_palindromes).
-export([superpalindromes_in_range/2]).

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).

superpalindromes_in_range(L, R) ->
    L1 = list_to_integer(L),
    R1 = list_to_integer(R),
    Low = trunc(math:sqrt(L1)),
    High = trunc(math:sqrt(R1)) + 1,
    count_super_palindromes(Low, High, L1, R1, 0).

count_super_palindromes(Current, High, L, R, Count) when Current > High ->
    Count;
count_super_palindromes(Current, High, L, R, Count) ->
    case is_palindrome(Current) of
        true ->
            Square = Current * Current,
            case is_palindrome(Square) andalso Square >= L andalso Square =< R of
                true -> count_super_palindromes(Current + 1, High, L, R, Count + 1);
                false -> count_super_palindromes(Current + 1, High, L, R, Count)
            end;
        false -> count_super_palindromes(Current + 1, High, L, R, Count)
    end.