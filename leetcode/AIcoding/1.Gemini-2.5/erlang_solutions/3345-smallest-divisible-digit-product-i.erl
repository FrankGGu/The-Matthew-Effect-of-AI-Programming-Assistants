-module(solution).
-export([smallestDivisibleDigitProduct/1]).

smallestDivisibleDigitProduct(N) when N == 1 -> 1;
smallestDivisibleDigitProduct(N) when N > 1, N =< 9 -> N;
smallestDivisibleDigitProduct(N) ->
    case N rem 10 of
        0 -> N;
        _ ->
            Multiplier = 10 div math:gcd(10, N),
            N * Multiplier
    end.