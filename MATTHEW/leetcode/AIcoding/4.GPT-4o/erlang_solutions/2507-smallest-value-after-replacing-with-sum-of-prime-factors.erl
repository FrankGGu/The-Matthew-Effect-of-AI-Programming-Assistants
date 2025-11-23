-module(solution).
-export([smallest_value/1]).

smallest_value(N) when N > 1 ->
    case prime_factors(N) of
        [] -> N;
        Factors -> lists:sum(Factors)
    end.

prime_factors(1) -> [];
prime_factors(N) -> prime_factors(N, 2, []).

prime_factors(N, Divisor, Acc) when Divisor * Divisor > N ->
    [N | Acc];
prime_factors(N, Divisor, Acc) ->
    case N rem Divisor of
        0 -> prime_factors(N div Divisor, Divisor, [Divisor | Acc]);
        _ -> prime_factors(N, Divisor + 1, Acc)
    end.