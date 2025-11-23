-module(primes).
-export([count_primes/1]).

count_primes(N) when N < 2 -> 0;
count_primes(N) ->
    IsPrime = erlang:make_ref(),
    {ok, Pid} = erlang:spawn_monitor(fun() -> sieve(IsPrime, N) end),
    receive
        {IsPrime, Count} -> Count
    after 5000 -> 0
    end.

sieve(IsPrime, N) ->
    Max = trunc(math:sqrt(N)) + 1,
    PrimeList = lists:seq(2, N),
    Sieve = lists:foldl(fun(P, Acc) ->
        case lists:member(P, Acc) of
            true -> lists:filter(fun(X) -> X rem P /= 0 end, Acc);
            false -> Acc
        end
    end, PrimeList, lists:seq(2, Max)),
    erlang:send(self(), {IsPrime, length(Sieve)}).