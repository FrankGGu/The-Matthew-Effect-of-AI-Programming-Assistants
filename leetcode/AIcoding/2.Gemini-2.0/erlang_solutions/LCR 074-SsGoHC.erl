-module(merge_intervals).
-export([merge/1]).

merge(Intervals) ->
  SortedIntervals = lists:sort(fun({A1, _}, {A2, _}) -> A1 < A2 end, Intervals),
  merge_sorted(SortedIntervals, []).

merge_sorted([], Acc) ->
  lists:reverse(Acc);
merge_sorted([H | T], []) ->
  merge_sorted(T, [H]);
merge_sorted([H | T], [Last | Acc]) ->
  {A1, B1} = Last,
  {A2, B2} = H,
  if
    A2 =< B1 ->
      NewLast = {A1, max(B1, B2)},
      merge_sorted(T, [NewLast | lists:delete(Last, Acc)]);
    true ->
      merge_sorted(T, [H | [Last | Acc]])
  end.