-module(solution).
-export([trainning_plan/1]).

trainning_plan(Num) ->
    trainning_plan(Num, 1, []).

trainning_plan(0, _, Acc) ->
    lists:reverse(Acc);
trainning_plan(N, K, Acc) ->
    case N rem K of
        0 ->
            trainning_plan(N div K, K + 1, [K | Acc]);
        _ ->
            trainning_plan(N, K + 1, Acc)
    end.