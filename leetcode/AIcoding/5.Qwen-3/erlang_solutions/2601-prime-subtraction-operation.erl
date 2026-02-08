-module(prime_subtraction_operation).
-export([canBeEqual/2]).

is_prime(N) ->
    is_prime(N, 2).

is_prime(2, _) -> true;
is_prime(3, _) -> true;
is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) -> is_prime(N, Div + 1).

get_primes_up_to(Max) ->
    lists:filter(fun(X) -> is_prime(X) end, lists:seq(2, Max)).

canBeEqual(A, B) ->
    Max = lists:max(A),
    Primes = get_primes_up_to(Max),
    can_be_equal(A, B, Primes).

can_be_equal([], [], _) -> true;
can_be_equal([], _, _) -> false;
can_be_equal(_, [], _) -> false;
can_be_equal([A | ARest], [B | BRest], Primes) ->
    case lists:member(A - B, Primes) of
        true -> can_be_equal(ARest, BRest, Primes);
        false -> false
    end.