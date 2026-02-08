-module(super_washing_machines).
-export([find_min_moves/1]).

find_min_moves(Machines) ->
  N = length(Machines),
  Sum = lists:sum(Machines),
  if Sum rem N /= 0 ->
    -1
  else
    Average = Sum div N,
    fold(Machines, 0, 0, Average, 0)
  end.

fold([], _, _, _, Max) ->
  Max;
fold([Machine | Rest], Sum, Count, Average, Max) ->
  Diff = Machine - Average,
  Sum1 = Sum + Diff,
  Count1 = max(abs(Sum1), abs(Diff)),
  Max1 = max(Max, Count1),
  fold(Rest, Sum1, Count + 1, Average, Max1).