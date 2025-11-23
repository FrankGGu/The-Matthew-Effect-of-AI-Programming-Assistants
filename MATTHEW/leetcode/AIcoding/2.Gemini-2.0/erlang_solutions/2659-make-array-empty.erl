-module(make_array_empty).
-export([solve/1]).

solve(Nums) ->
  Len = length(Nums),
  IndexedNums = lists:zip(Nums, lists:seq(1, Len)),
  SortedNums = lists:keysort(1, IndexedNums),
  solve_helper(SortedNums, 0, Len).

solve_helper([], Acc, _) ->
  Acc;
solve_helper([H|T], Acc, Len) ->
  {_, Index} = H,
  Cycles = count_cycles(T, Index, Len),
  solve_helper(T, Acc + (Index + Cycles - 1) rem Len + 1, Len).

count_cycles([], _, _) ->
  0;
count_cycles(T, Index, Len) ->
  count_cycles_helper(T, Index, Len, 0).

count_cycles_helper([], _, _, Acc) ->
  Acc;
count_cycles_helper([{_, I}|Rest], Index, Len, Acc) ->
  if
    I < Index ->
      count_cycles_helper(Rest, Index, Len, Acc + 1);
    true ->
      count_cycles_helper(Rest, Index, Len, Acc)
  end.