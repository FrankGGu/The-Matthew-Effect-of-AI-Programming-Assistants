-module(solution).
-export([max_distinct_primes/1]).

is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) -> is_prime(N, Div + 1).

primes_up_to(2) -> [2];
primes_up_to(N) ->
    lists:filter(fun is_prime/1, lists:seq(2, N)).

split_number(N) ->
    lists:foldl(
        fun(Div, {Count, Primes}) ->
            if
                N rem Div == 0 ->
                    NewCount = Count + 1,
                    NewPrimes = [Div | Primes],
                    {NewCount, NewPrimes};
                true ->
                    {Count, Primes}
            end
        end,
        {0, []},
        primes_up_to(N)
    ).

max_distinct_primes(N) ->
    {Count, _} = split_number(N),
    Count.