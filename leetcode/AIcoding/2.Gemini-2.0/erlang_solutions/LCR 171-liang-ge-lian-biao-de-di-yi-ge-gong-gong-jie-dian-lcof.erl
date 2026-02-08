-module(training_plan_v).
-export([training_plan/1]).

training_plan(tasks) ->
  training_plan(tasks, []).

training_plan([], Acc) ->
  lists:reverse(Acc);
training_plan([H|T], Acc) ->
  training_plan(T, [H|Acc]).