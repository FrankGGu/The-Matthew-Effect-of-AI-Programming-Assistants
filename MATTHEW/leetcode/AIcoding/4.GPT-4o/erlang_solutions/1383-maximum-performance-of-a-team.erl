-module(solution).
-export([max_performance/3]).

max_performance(N, Speed, Efficiency) ->
    Pairs = lists:zip(Speed, Efficiency),
    SortedPairs = lists:sort(fun({_, E1}, {_, E2}) -> E1 > E2 end, Pairs),
    max_performance_helper(SortedPairs, N, 0, 0, 0).

max_performance_helper([], _, _, _, Acc) -> Acc rem (10^9 + 7);
max_performance_helper([{S, E} | Rest], N, CurrentSpeed, Count, Acc) ->
    NewSpeed = CurrentSpeed + S,
    NewCount = Count + 1,
    NewAcc = if NewCount =< N -> max(Acc, NewSpeed * E); true -> Acc end,
    max_performance_helper(Rest, N, NewSpeed, NewCount, NewAcc).