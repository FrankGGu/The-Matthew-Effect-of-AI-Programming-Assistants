-spec two_city_sched_cost(Costs :: [[integer()]]) -> integer().
two_city_sched_cost(Costs) ->
    Sorted = lists:sort(fun([A1, B1], [A2, B2]) -> (A1 - B1) =< (A2 - B2) end, Costs),
    N = length(Costs) div 2,
    {First, Second} = lists:split(N, Sorted),
    SumFirst = lists:sum([A || [A, _B] <- First]),
    SumSecond = lists:sum([B || [_A, B] <- Second]),
    SumFirst + SumSecond.