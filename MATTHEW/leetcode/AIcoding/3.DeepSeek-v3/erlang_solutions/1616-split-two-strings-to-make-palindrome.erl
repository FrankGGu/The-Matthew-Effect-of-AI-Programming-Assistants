-smodule(split_two_strings).
-export([check_palindrome_formation/2]).

check_palindrome_formation(A, B) ->
    check(A, B) orelse check(B, A).

check(A, B) ->
    N = length(A),
    check_helper(A, B, 0, N - 1).

check_helper(A, B, I, J) when I >= J ->
    true;
check_helper(A, B, I, J) ->
    case {lists:nth(I + 1, A), lists:nth(J + 1, B)} of
        {X, X} -> check_helper(A, B, I + 1, J - 1);
        _ -> is_palindrome(A, I, J) orelse is_palindrome(B, I, J)
    end.

is_palindrome(S, I, J) ->
    is_palindrome_helper(S, I, J).

is_palindrome_helper(S, I, J) when I >= J ->
    true;
is_palindrome_helper(S, I, J) ->
    case lists:nth(I + 1, S) == lists:nth(J + 1, S) of
        true -> is_palindrome_helper(S, I + 1, J - 1);
        false -> false
    end.