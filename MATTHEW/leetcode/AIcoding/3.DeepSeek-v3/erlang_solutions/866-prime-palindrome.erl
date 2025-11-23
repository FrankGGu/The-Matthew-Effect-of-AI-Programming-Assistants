-module(solution).
-export([prime_palindrome/1]).

prime_palindrome(N) ->
    if
        N =< 2 -> 2;
        true -> find_next(N)
    end.

find_next(N) ->
    case is_palindrome(N) andalso is_prime(N) of
        true -> N;
        false -> find_next(N + 1)
    end.

is_palindrome(N) ->
    S = integer_to_list(N),
    S =:= lists:reverse(S).

is_prime(N) when N =< 1 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 =:= 0 -> false;
is_prime(N) -> is_prime(N, 3).

is_prime(N, K) when K * K > N -> true;
is_prime(N, K) when N rem K =:= 0 -> false;
is_prime(N, K) -> is_prime(N, K + 2).