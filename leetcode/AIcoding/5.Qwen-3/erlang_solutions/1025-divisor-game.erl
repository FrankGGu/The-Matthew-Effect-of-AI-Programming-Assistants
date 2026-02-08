-module(divisor_game).
-export([ok/1]).

ok(N) ->
    ok(N, 0).

ok(1, _) ->
    false;
ok(2, _) ->
    true;
ok(N, Turn) ->
    lists:any(fun(D) -> not ok(N - D, 1 - Turn) end, divisors(N)).

divisors(N) ->
    [D || D <- lists:seq(1, N-1), N rem D == 0].