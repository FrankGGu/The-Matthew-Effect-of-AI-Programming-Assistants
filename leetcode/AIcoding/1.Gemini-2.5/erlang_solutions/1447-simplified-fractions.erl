-module(solution).
-export([simplified_fractions/1]).

simplified_fractions(N) ->
    [ io_lib:format("~w/~w", [P, Q])
      || Q <- lists:seq(2, N),
         P <- lists:seq(1, Q - 1),
         math:gcd(P, Q) == 1
    ].