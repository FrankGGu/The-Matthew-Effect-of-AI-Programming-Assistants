-module(prime_pairs_with_target_sum).
-export([solve/1]).

solve(Target) ->
    IsPrime = fun(N) -> is_prime(N) end,
    Pairs = find_pairs(Target, IsPrime),
    lists:sort(Pairs).

is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) -> is_prime(N, 2).

is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) -> is_prime(N, Div + 1).

find_pairs(Target, IsPrime) ->
    find_pairs(Target, 2, IsPrime, []).

find_pairs(_, Max, _, Acc) when Max > Target div 2 -> Acc;
find_pairs(Target, Start, IsPrime, Acc) ->
    A = Start,
    B = Target - A,
    if
        A >= B -> Acc;
        IsPrime(A) andalso IsPrime(B) -> find_pairs(Target, Start + 1, IsPrime, [{A, B} | Acc]);
        true -> find_pairs(Target, Start + 1, IsPrime, Acc)
    end.