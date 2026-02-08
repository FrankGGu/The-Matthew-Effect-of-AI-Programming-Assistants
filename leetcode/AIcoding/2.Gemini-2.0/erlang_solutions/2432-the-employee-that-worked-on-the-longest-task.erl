-module(longest_task).
-export([longest_task/1]).

longest_task(Logs) ->
  longest_task_helper(Logs, 0, 0, 0).

longest_task_helper([], MaxId, MaxTime, _) ->
  MaxId;
longest_task_helper([H|T], MaxId, MaxTime, PrevTime) ->
  [Id, EndTime] = H,
  Duration = EndTime - PrevTime,
  case Duration > MaxTime of
    true ->
      longest_task_helper(T, Id, Duration, EndTime);
    false ->
      case Duration == MaxTime andalso Id < MaxId of
        true ->
          longest_task_helper(T, Id, Duration, EndTime);
        false ->
          longest_task_helper(T, MaxId, MaxTime, EndTime)
      end
  end.