-module(solution).
-export([trainning_plan/1]).

trainning_plan(Plan) ->
    trainning_plan(Plan, 0).

trainning_plan([], _Count) ->
    0;
trainning_plan([H | T], Count) ->
    case H of
        0 -> trainning_plan(T, Count);
        _ -> trainning_plan(T, Count + 1)
    end.