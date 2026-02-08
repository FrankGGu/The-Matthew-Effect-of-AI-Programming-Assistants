-module(solution).
-export([solve/1]).

solve(Times) ->
    SortedTimes = lists:sort(Times),
    bridge(SortedTimes).

bridge([]) -> 0;
bridge([T]) -> T;
bridge([T1, T2]) -> T2;
bridge([T1, T2, T3]) -> T1 + T2 + T3;
bridge(Times) ->
    N = length(Times),
    [T1, T2 | _] = Times,
    Tn = lists:last(Times),
    Tn_1 = lists:nth(N - 1, Times),

    Cost1 = T2 + T1 + Tn + T2,
    RemainingTimes = lists:sublist(Times, 1, N - 2),
    Total1 = Cost1 + bridge(RemainingTimes),

    Cost2 = Tn + T1 + Tn_1 + T1,
    Total2 = Cost2 + bridge(RemainingTimes),

    min(Total1, Total2).