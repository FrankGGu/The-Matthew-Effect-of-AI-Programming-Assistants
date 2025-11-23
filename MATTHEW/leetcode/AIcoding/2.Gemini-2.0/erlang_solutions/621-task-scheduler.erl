-module(task_scheduler).
-export([least_interval/2]).

least_interval(Tasks, N) ->
    Counts = lists:foldl(fun(Task, Acc) ->
                                  maps:update_with(Task, fun(Count) -> Count + 1 end, 1, Acc)
                          end, #{}, Tasks),
    SortedCounts = lists:reverse(lists:sort(fun({_, C1}, {_, C2}) -> C1 < C2 end, maps:to_list(Counts))),
    MaxCount = element(2, lists:nth(1, SortedCounts)),
    MaxCountTasks = lists:foldl(fun({_, Count}, Acc) ->
                                         if Count == MaxCount then Acc + 1 else Acc end
                                 end, 0, SortedCounts),
    max(length(Tasks), (MaxCount - 1) * (N + 1) + MaxCountTasks).