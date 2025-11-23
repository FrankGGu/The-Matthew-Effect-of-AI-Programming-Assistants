-module(minimum_processing_time).
-export([solve/1]).

solve(ProcessTime) ->
  {Processors, Tasks} = ProcessTime,
  SortedProcessors = lists:sort(Processors),
  SortedTasks = lists:sort(Tasks),
  solve_helper(SortedProcessors, SortedTasks, []).

solve_helper([], _, Acc) ->
  lists:max(Acc);
solve_helper([Processor | RestProcessors], Tasks, Acc) ->
  Task1 = lists:nth(1, Tasks),
  Task2 = lists:nth(2, Tasks),
  Task3 = lists:nth(3, Tasks),
  Task4 = lists:nth(4, Tasks),
  MaxTime = max([Processor + Task1, Processor + Task2, Processor + Task3, Processor + Task4]),
  solve_helper(RestProcessors, lists:nthtail(4, Tasks), [MaxTime | Acc]).