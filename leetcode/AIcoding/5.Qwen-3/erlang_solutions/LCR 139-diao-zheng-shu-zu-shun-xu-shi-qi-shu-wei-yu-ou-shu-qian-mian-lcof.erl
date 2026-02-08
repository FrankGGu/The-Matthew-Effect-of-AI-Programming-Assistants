-module(solution).
-export([trainning_plan/1]).

trainning_plan(Num) ->
    trainning_plan(Num, 1, []).

trainning_plan(0, _, Acc) ->
    lists:reverse(Acc);
trainning_plan(N, I, Acc) ->
    trainning_plan(N - 1, I + 1, [I | Acc]).