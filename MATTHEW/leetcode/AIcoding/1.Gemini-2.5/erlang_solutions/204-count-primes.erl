-module(solution).
-export([countPrimes/1]).

countPrimes(N) when N =< 2 ->
    0;
countPrimes(N) ->
    % Create an array of size N, initialized to 1 (true)
    % Indices 0 and 1 are not prime, so set them to 0 (false)
    IsPrime = array:new([{size, N}, {fixed, true}, {default, 1}]),
    IsPrime1 = array:set(0, 0, IsPrime),
    IsPrime2 = array:set(1, 0, IsPrime1),

    % Iterate from P = 2 up to sqrt(N-1)
    MaxP = floor(math:sqrt(N - 1)),
    FinalIsPrime = sieve_loop(2, MaxP, N, IsPrime2),

    % Count the primes
    count_primes_in_array(2, N, FinalIsPrime, 0).

sieve_loop(P, MaxP, N, IsPrime) when P =< MaxP ->
    case array:get(P, IsPrime) of
        1 -> % P is prime
            % Mark multiples of P as not prime
            UpdatedIsPrime = mark_multiples(P * P, P, N, IsPrime),
            sieve_loop(P + 1, MaxP, N, UpdatedIsPrime);
        0 -> % P is not prime
            sieve_loop(P + 1, MaxP, N, IsPrime)
    end;
sieve_loop(_P, _MaxP, _N, IsPrime) ->
    IsPrime.

mark_multiples(J, P, N, CurrentIsPrime) when J < N ->
    UpdatedIsPrime = array:set(J, 0, CurrentIsPrime),
    mark_multiples(J + P, P, N, UpdatedIsPrime);
mark_multiples(_J, _P, _N, CurrentIsPrime) ->
    CurrentIsPrime.

count_primes_in_array(I, N, IsPrime, Count) when I < N ->
    case array:get(I, IsPrime) of
        1 -> count_primes_in_array(I + 1, N, IsPrime, Count + 1);
        0 -> count_primes_in_array(I + 1, N, IsPrime, Count)
    end;
count_primes_in_array(_I, _N, _IsPrime, Count) ->
    Count.