-module(solution).
-export([largest_palindrome_divisible_by_k/1]).

largest_palindrome_divisible_by_k(K) ->
    Max = 10 * K - 1,
    Min = K,
    find_largest_palindrome(Max, Min, K, -1).

find_largest_palindrome(Current, Min, K, Result) when Current >= Min ->
    case is_palindrome(Current) andalso (Current rem K =:= 0) of
        true -> Current;
        false -> find_largest_palindrome(Current - 1, Min, K, Result)
    end;
find_largest_palindrome(_, _, _, Result) ->
    Result.

is_palindrome(N) ->
    S = integer_to_list(N),
    S =:= lists:reverse(S).