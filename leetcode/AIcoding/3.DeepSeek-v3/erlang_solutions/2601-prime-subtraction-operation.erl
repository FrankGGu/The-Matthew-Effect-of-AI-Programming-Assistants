-module(solution).
-export([prime_subtraction/1]).

prime_subtraction(Nums) ->
    Primes = get_primes(lists:max(Nums)),
    check_possible(Nums, Primes, 0).

get_primes(Max) ->
    Sieve = lists:duplicate(Max + 1, true),
    Sieve1 = setelement(1, Sieve, false),
    Sieve2 = setelement(2, Sieve1, false),
    get_primes_helper(2, Max, Sieve2).

get_primes_helper(P, Max, Sieve) when P * P > Max ->
    [I || I <- lists:seq(2, Max), element(I, Sieve)];
get_primes_helper(P, Max, Sieve) ->
    case element(P, Sieve) of
        true ->
            Sieve1 = mark_non_primes(P, P, Max, Sieve),
            get_primes_helper(P + 1, Max, Sieve1);
        false ->
            get_primes_helper(P + 1, Max, Sieve)
    end.

mark_non_primes(P, Current, Max, Sieve) when Current > Max ->
    Sieve;
mark_non_primes(P, Current, Max, Sieve) ->
    Sieve1 = setelement(Current, Sieve, false),
    mark_non_primes(P, Current + P, Max, Sieve1).

check_possible([], _Primes, _Prev) -> true;
check_possible([H | T], Primes, Prev) ->
    case H > Prev of
        true ->
            check_possible(T, Primes, H);
        false ->
            case find_prime(H - Prev, Primes) of
                false -> false;
                _Prime -> check_possible(T, Primes, H)
            end
    end.

find_prime(Diff, Primes) ->
    case lists:dropwhile(fun(P) -> P >= Diff end, lists:reverse(Primes)) of
        [] -> false;
        [P | _] -> P
    end.