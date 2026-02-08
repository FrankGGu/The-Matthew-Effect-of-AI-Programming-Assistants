-module(solution).
-export([training_plan/2]).

-training_plan(Days, target) ->
    training_plan(Days, target, 0, 0).

training_plan(0, target, Max, _) ->
    Max;
training_plan(Days, target, Max, Current) ->
    NewMax = max(Current, Max),
    case Days rem 7 of
        0 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        1 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        2 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        3 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        4 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        5 -> 
            training_plan(Days - 1, target, NewMax, Current + 1);
        6 -> 
            training_plan(Days - 1, target, NewMax, Current + 1)
    end.