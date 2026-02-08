-module(average_salary).
-export([average/1]).

average(Salary) ->
  Sorted = lists:sort(Salary),
  [_Min | Rest] = Sorted,
  {_, [_Max]} = lists:split(length(Rest) - 1, Rest),
  Sum = lists:sum(Rest),
  Len = length(Rest),
  Sum / Len.