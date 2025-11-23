-module(prime_subtraction).
-export([prime_subtraction_operation/1]).

prime_subtraction_operation(Nums) ->
    primes_less_than_or_equal_to(1000),
    prime_subtraction_operation(Nums, 0).

prime_subtraction_operation([], _Last) ->
    true;
prime_subtraction_operation([Num | Rest], Last) ->
    case find_prime_to_subtract(Num, Last) of
        none ->
            false;
        Prime ->
            prime_subtraction_operation(Rest, Num - Prime)
    end.

find_prime_to_subtract(Num, Last) ->
    find_prime_to_subtract(Num, Last, lists:reverse(primes())).

find_prime_to_subtract(Num, Last, []) ->
    none;
find_prime_to_subtract(Num, Last, [Prime | Rest]) ->
    case Num - Prime > Last andalso Prime > 0 of
        true ->
            Prime;
        false ->
            find_prime_to_subtract(Num, Last, Rest)
    end.

primes() ->
    ets:lookup(primes_table, primes).

primes_less_than_or_equal_to(N) ->
    case ets:info(primes_table) of
        undefined ->
            Sieve = lists:seq(2, N),
            Primes = find_primes(Sieve, []),
            ets:new(primes_table, [set, public, named_table]),
            ets:insert(primes_table, {primes, Primes}),
            Primes;
        _ ->
            ok
    end.

find_primes([], Acc) ->
    lists:reverse(Acc);
find_primes([P | Rest], Acc) ->
    find_primes(lists:filter(fun(X) -> X rem P /= 0 end, Rest), [P | Acc]).