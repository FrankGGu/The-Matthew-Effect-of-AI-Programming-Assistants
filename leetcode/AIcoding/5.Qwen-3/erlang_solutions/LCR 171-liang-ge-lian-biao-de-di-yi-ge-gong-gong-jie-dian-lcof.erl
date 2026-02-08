-module(solution).
-export([trainning_plan/1]).

trainning_plan(Num) ->
    trainning_plan(Num, 1, 0).

trainning_plan(0, _, Acc) ->
    Acc;
trainning_plan(N, Step, Acc) ->
    trainning_plan(N - 1, Step + 1, Acc + Step).