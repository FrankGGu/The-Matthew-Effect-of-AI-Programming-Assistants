-module(solution).
-export([closest_primes/2]).

closest_primes(Left, Right) ->
    Primes = find_primes(Left, Right),
    case length(Primes) < 2 of
        true -> [-1, -1];
        false -> find_closest_pair(Primes)
    end.

find_primes(Left, Right) ->
    lists:filter(fun(X) -> is_prime(X) end, lists:seq(Left, Right)).

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 =:= 0 -> false;
is_prime(N) -> is_prime(N, 3, math:sqrt(N)).

is_prime(N, K, Limit) when K > Limit -> true;
is_prime(N, K, Limit) ->
    case N rem K =:= 0 of
        true -> false;
        false -> is_prime(N, K + 2, Limit)
    end.

find_closest_pair([H1, H2 | T]) ->
    find_closest_pair(T, H1, H2, H2 - H1).

find_closest_pair([], P1, P2, _) -> [P1, P2];
find_closest_pair([H | T], P1, P2, MinDiff) ->
    Diff = H - P2,
    if
        Diff < MinDiff -> find_closest_pair(T, P2, H, Diff);
        true -> find_closest_pair(T, P1, P2, MinDiff)
    end.