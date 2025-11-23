-spec max_satisfaction(Satisfaction :: [integer()]) -> integer().
max_satisfaction(Satisfaction) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Satisfaction),
    max_satisfaction_helper(Sorted, 0, 0, 0).

max_satisfaction_helper([], Sum, Acc, Max) ->
    Max;
max_satisfaction_helper([H | T], Sum, Acc, Max) ->
    NewSum = Sum + H,
    NewAcc = Acc + NewSum,
    NewMax = max(NewAcc, Max),
    if
        NewSum < 0 -> NewMax;
        true -> max_satisfaction_helper(T, NewSum, NewAcc, NewMax)
    end.