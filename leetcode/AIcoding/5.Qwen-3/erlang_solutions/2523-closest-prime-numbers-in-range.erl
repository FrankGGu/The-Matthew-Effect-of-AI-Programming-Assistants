-module(closest_primes).
-export([closest_prime/2]).

is_prime(N) ->
    is_prime(N, 2).

is_prime(N, I) when I * I > N ->
    true;
is_prime(N, I) when N rem I == 0 ->
    false;
is_prime(N, I) ->
    is_prime(N, I + 1).

primes_in_range(Low, High) ->
    [P || P <- lists:seq(Low, High), is_prime(P)].

find_closest_primes([], _) -> [];
find_closest_primes([_], _) -> [];
find_closest_primes([A, B | T], Acc) ->
    find_closest_primes([B | T], [{A, B} | Acc]);
find_closest_primes([A, B | T], Acc) ->
    find_closest_primes([B | T], [{A, B} | Acc]).

closest_prime(Low, High) ->
    Primes = primes_in_range(Low, High),
    case length(Primes) of
        0 -> [];
        1 -> [];
        _ -> lists:last(find_closest_primes(Primes, []))
    end.