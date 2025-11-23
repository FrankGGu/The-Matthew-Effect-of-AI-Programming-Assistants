-spec training_plan(Exercises :: [integer()]) -> [integer()].
training_plan(Exercises) ->
    lists:reverse(training_plan(Exercises, [])).

training_plan([], Acc) -> Acc;
training_plan([H|T], Acc) ->
    training_plan(T, [H + lists:sum(Acc)|Acc]).