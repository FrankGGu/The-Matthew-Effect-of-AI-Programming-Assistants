-module(solution).
-export([power_of_heroes/1]).

power_of_heroes(N) when N >= 1, N =< 10^5 ->
    lists:map(fun(X) -> pow(X) end, lists:seq(1, N)).

pow(X) ->
    (X * X * X) rem (10^9 + 7).