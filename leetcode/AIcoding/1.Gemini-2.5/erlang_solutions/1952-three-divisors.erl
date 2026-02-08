-module(solution).
-export([hasThreeDivisors/1]).

hasThreeDivisors(N) when N < 4 -> false;
hasThreeDivisors(N) ->
    S = round(math:sqrt(N)),
    case S * S == N of
        true -> is_prime(S);
        false -> false
    end.

is_prime(Num) when Num =< 1 -> false;
is_prime(2) -> true;
is_prime(Num) when Num rem 2 == 0 -> false;
is_prime(Num) ->
    check_prime_loop(Num, 3).

check_prime_loop(Num, Divisor) when Divisor * Divisor > Num -> true;
check_prime_loop(Num, Divisor) when Num rem Divisor == 0 -> false;
check_prime_loop(Num, Divisor) ->
    check_prime_loop(Num, Divisor + 2).