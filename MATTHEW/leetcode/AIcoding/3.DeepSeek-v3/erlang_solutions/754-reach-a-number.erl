-spec reach_number(Target :: integer()) -> integer().
reach_number(Target) ->
    AbsTarget = abs(Target),
    reach_number_helper(AbsTarget, 0, 0).

reach_number_helper(Target, Sum, Steps) when Sum >= Target, (Sum - Target) rem 2 =:= 0 ->
    Steps;
reach_number_helper(Target, Sum, Steps) ->
    NewSteps = Steps + 1,
    reach_number_helper(Target, Sum + NewSteps, NewSteps).