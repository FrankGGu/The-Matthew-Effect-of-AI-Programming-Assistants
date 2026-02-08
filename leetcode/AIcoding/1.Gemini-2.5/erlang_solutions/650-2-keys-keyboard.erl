-module(solution).
-export([minSteps/1]).

minSteps(1) -> 0;
minSteps(N) ->
    min_steps_acc(N, 2, 0).

min_steps_acc(1, _Divisor, Acc) ->
    Acc;
min_steps_acc(N, Divisor, Acc) when N rem Divisor == 0 ->
    min_steps_acc(N div Divisor, Divisor, Acc + Divisor);
min_steps_acc(N, Divisor, Acc) when Divisor * Divisor > N ->
    Acc + N;
min_steps_acc(N, Divisor, Acc) ->
    min_steps_acc(N, Divisor + 1, Acc).