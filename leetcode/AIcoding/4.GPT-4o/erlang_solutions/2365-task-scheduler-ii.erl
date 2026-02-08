-module(solution).
-export([leastInterval/2]).

leastInterval(Jobs, N) ->
    MaxCount = lists:max(lists:map(fun({_, Count}) -> Count end, lists:foldl(fun(J, Acc) -> lists:keyupdate(J, 2, Acc, [{J, 1}]) end, [], Jobs))),
    MaxCountJobs = lists:filter(fun({_, Count}) -> Count =:= MaxCount end, lists:foldl(fun(J, Acc) -> lists:keyupdate(J, 2, Acc, [{J, 1}]) end, [], Jobs)),
    MaxCountJobsCount = length(MaxCountJobs),
    TotalJobs = length(Jobs),
    Max(0, TotalJobs + (MaxCount - 1) * (N + 1) - MaxCountJobsCount).

Max(A, B) when A > B -> A;
Max(A, B) -> B.