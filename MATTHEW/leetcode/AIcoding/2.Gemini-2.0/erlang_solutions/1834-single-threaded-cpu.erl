-module(single_threaded_cpu).
-export([schedule/1]).

schedule(tasks) ->
  process_tasks(lists:sort(fun({A1, B1}, {A2, B2}) -> A1 < A2 end, lists:zip(tasks, lists:seq(0, length(tasks) - 1))), 0, []).

process_tasks([], _, Acc) ->
  lists:reverse(Acc);
process_tasks(Tasks, CurrentTime, Acc) ->
  RunnableTasks = [Task || {Task, _} <- Tasks, {ArrivalTime, _} = Task, ArrivalTime =< CurrentTime].
  case RunnableTasks of
    [] ->
      NextArrivalTime = lists:min([ArrivalTime || {ArrivalTime, _} <- lists:map(fun({Task, _}) -> {A, _} = Task, A end, Tasks)]),
      process_tasks(Tasks, NextArrivalTime, Acc);
    _ ->
      {BestTask, Index} = find_best_task(RunnableTasks),
      {_, OriginalIndex} = lists:nth(Index, Tasks),
      {ArrivalTime, ProcessTime} = BestTask,
      NewTime = CurrentTime + ProcessTime,
      RemainingTasks = lists:delete_at(Index + 1, Tasks),
      process_tasks(RemainingTasks, NewTime, [OriginalIndex | Acc])
  end.

find_best_task([Task]) ->
  {Task, 1};
find_best_task(Tasks) ->
  find_best_task_helper(Tasks, 1, {hd(Tasks), 1}).

find_best_task_helper([H|T], Index, {BestTask, BestIndex}) ->
  case T of
    [] ->
      {BestTask, BestIndex};
    [Next|Rest] ->
      {_, ProcessTime1} = BestTask,
      {_, ProcessTime2} = Next,
      if ProcessTime2 < ProcessTime1 ->
        find_best_task_helper([Next|Rest], Index + 1, {Next, Index + 1});
      true ->
        find_best_task_helper(T, Index + 1, {BestTask, BestIndex})
      end
  end.