-spec max_prime_difference(Nums :: [integer()]) -> integer().
max_prime_difference(Nums) ->
    Primes = lists:filter(fun(X) -> is_prime(X) end, Nums),
    case Primes of
        [] -> 0;
        _ ->
            Min = lists:min(Primes),
            Max = lists:max(Primes),
            lists:max([abs(I - J) || I <- lists:seq(1, length(Nums)), J <- lists:seq(1, length(Nums)), lists:nth(I, Nums) == Min, lists:nth(J, Nums) == Max])
    end.

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, D) when D * D > N -> true;
is_prime(N, D) when N rem D == 0 -> false;
is_prime(N, D) -> is_prime(N, D + 1).