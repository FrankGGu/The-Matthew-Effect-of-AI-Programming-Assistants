-module(solution).
-export([fitness_plan/2]).

fitness_plan(N, NList) ->
    fitness_plan(N, NList, 0).

fitness_plan(_, [], Acc) ->
    Acc;
fitness_plan(N, [H | T], Acc) ->
    fitness_plan(N, T, Acc + (if H =< 0 -> 0; H > 0 -> min(N, Acc + H) end)).