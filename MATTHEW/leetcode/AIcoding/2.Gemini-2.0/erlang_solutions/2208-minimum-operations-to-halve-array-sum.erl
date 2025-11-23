-module(minimum_operations).
-export([halve_array_sum/1]).

halve_array_sum(Nums) ->
  FloatNums = [float(N) || N <- Nums],
  Sum = lists:sum(FloatNums),
  PriorityQueue = qlc:qsort([{-(N), N} || N <- FloatNums]),
  halve_array_sum_helper(PriorityQueue, Sum, 0, 0).

halve_array_sum_helper([{-(N), N} | T], Sum, Current, Count) ->
  HalfSum = Sum / 2.0,
  NewCurrent = Current + (N / 2.0),
  if NewCurrent >= HalfSum ->
    Count + 1
  else
    NewN = N / 2.0,
    NewPriorityQueue = lists:sort(fun({-(A), _}, {-(B), _}) -> A > B end, [{-(NewN), NewN} | T]),
    halve_array_sum_helper(NewPriorityQueue, Sum, NewCurrent, Count + 1);
halve_array_sum_helper([], _, _, _) ->
  0.