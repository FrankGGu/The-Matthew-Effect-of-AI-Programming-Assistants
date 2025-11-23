-spec count_primes(N :: integer()) -> integer().
count_primes(N) when N < 2 -> 0;
count_primes(N) ->
    count_primes_sieve(N, lists:duplicate(N, true), 2, 0).

count_primes_sieve(_, [], _, Count) -> Count;
count_primes_sieve(N, [true | Rest], P, Count) when P * P > N -> Count + length(Rest);
count_primes_sieve(N, [true | Rest], P, Count) ->
    NewRest = sieve_multiples(Rest, P, P * P, N),
    count_primes_sieve(N, NewRest, P + 1, Count).

sieve_multiples([], _, _, _) -> [];
sieve_multiples([_ | Tail], P, Start, N) when Start >= N -> [false | sieve_multiples(Tail, P, Start + P, N)];
sieve_multiples([true | Tail], P, Start, N) -> [false | sieve_multiples(Tail, P, Start + P, N)];
sieve_multiples([false | Tail], P, Start, N) -> [false | sieve_multiples(Tail, P, Start + P, N)].
