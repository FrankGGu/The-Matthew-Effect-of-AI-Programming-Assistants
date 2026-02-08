-module(binary_tree_tasks).
-export([can_finish/2]).

can_finish(Tasks, Dependencies) ->
  graph(Tasks, Dependencies, []).

graph(Tasks, Dependencies, Visited) ->
  case Tasks of
    [] -> true;
    [Task|Rest] ->
      case lists:member(Task, Visited) of
        true -> false;
        false ->
          Pre = [PreTask || {PreTask, Task} <- Dependencies],
          case graph(Pre, Dependencies, [Task|Visited]) of
            true -> graph(Rest, Dependencies, Visited);
            false -> false
          end
      end
  end.