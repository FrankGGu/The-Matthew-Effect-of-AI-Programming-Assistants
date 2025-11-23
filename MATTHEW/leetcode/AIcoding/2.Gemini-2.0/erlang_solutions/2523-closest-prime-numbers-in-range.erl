-module(closest_primes).
-export([closest_primes/2]).

closest_primes(Left, Right) ->
    Primes = find_primes(Left, Right),
    find_closest(Primes).

find_primes(Left, Right) ->
    lists:filter(fun(N) -> is_prime(N) end, lists:seq(max(2, Left), Right)).

is_prime(N) ->
    is_prime_helper(N, 2).

is_prime_helper(N, I) when I * I > N ->
    true;
is_prime_helper(N, I) when N rem I == 0 ->
    false;
is_prime_helper(N, I) ->
    is_prime_helper(N, I + 1).

find_closest([]) ->
    [-1, -1];
find_closest([_]) ->
    [-1, -1];
find_closest(Primes) ->
    find_closest_helper(Primes, hd(Primes), lists:nth(2, Primes), lists:nth(2, Primes) - hd(Primes), [-1, -1], tl(Primes)).

find_closest_helper([_], P1, P2, Diff, Result, _) ->
    Result;
find_closest_helper([H|T], P1, P2, Diff, Result, Rest) ->
    Diff2 = H - P2,
    if Diff2 < Diff ->
        find_closest_helper(T, P2, H, Diff2, [P2, H], tl(Rest));
    true ->
        find_closest_helper(T, P2, H, Diff, Result, tl(Rest))
    end.