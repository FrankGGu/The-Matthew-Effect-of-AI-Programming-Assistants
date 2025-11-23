-module(solution).
-export([training_plan/1]).

training_plan(Nums) ->
    training_plan(Nums, 0, 0).

training_plan([], _, Acc) ->
    Acc;
training_plan([H | T], Index, Acc) ->
    case Index rem 2 of
        0 -> training_plan(T, Index + 1, Acc + H);
        _ -> training_plan(T, Index + 1, Acc)
    end.