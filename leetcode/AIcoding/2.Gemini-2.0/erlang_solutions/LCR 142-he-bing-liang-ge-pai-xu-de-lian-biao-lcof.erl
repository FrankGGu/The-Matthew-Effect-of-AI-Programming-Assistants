-module(training_plan_iv).
-export([training_plan/1]).

training_plan(tasks) ->
  Len = length(tasks),
  training_plan_helper(tasks, Len, 0, []).

training_plan_helper([], _, Acc, Path) ->
  {ok, Path};
training_plan_helper(Tasks, Len, Acc, Path) ->
  PossibleTasks = lists:filter(fun(T) -> can_execute(T, Path) end, Tasks),
  case PossibleTasks of
    [] ->
      {error, Acc};
    _ ->
      lists:foldl(
        fun(Task, {_, BestPath}) ->
          NewTasks = lists:delete(Task, Tasks),
          case training_plan_helper(NewTasks, Len, Acc + Task, Path ++ [Task]) of
            {ok, NewPath} ->
              {ok, NewPath};
            {error, NewAcc} ->
              {error, max(Acc, NewAcc)}
          end
        end,
        {error, Acc},
        PossibleTasks
      )
  end.

can_execute(Task, Path) ->
  case Path of
    [] ->
      true;
    _ ->
      true
  end.