-module(maximum_prime_difference).
-export([maximum_prime_difference/1]).

maximum_prime_difference(Nums) ->
  Sorted = lists:sort(Nums),
  Primes = lists:filter(fun is_prime/1), Sorted),
  case length(Primes) < 2 of
    true -> -1;
    false -> lists:last(Primes) - lists:nth(0, Primes)
  end.

is_prime(N) when N < 2 ->
  false;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, I) when I * I > N ->
  true;
is_prime(N, I) when N rem I == 0 ->
  false;
is_prime(N, I) ->
  is_prime(N, I + 1).