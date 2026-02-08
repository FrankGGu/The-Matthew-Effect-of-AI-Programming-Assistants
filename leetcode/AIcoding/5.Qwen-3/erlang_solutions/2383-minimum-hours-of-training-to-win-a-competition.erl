-module(minimum_hours_of_training).
-export([minTrainingHours/2]).

minTrainingHours(Experience, C) ->
    minTrainingHours(Experience, C, 0).

minTrainingHours([], _, Acc) ->
    Acc;
minTrainingHours([H | T], C, Acc) ->
    if
        H >= C ->
            minTrainingHours(T, C, Acc);
        true ->
            Need = C - H,
            minTrainingHours(T, C, Acc + Need)
    end.