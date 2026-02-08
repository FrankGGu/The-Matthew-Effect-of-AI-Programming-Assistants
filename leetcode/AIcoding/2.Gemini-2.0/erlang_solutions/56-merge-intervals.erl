-module(merge_intervals).
-export([merge/1]).

merge(Intervals) ->
  SortedIntervals = lists:sort(fun({A1, _}, {A2, _}) -> A1 < A2 end, Intervals),
  merge_sorted(SortedIntervals, []).

merge_sorted([], Acc) ->
  lists:reverse(Acc);
merge_sorted([Head | Tail], []) ->
  merge_sorted(Tail, [Head]);
merge_sorted([Head | Tail], [Last | Rest]) ->
  {A1, B1} = Last,
  {A2, B2} = Head,
  if
    A2 =< B1 ->
      merge_sorted(Tail, [{A1, max(B1, B2)} | Rest]);
    true ->
      merge_sorted(Tail, [Head, Last | Rest])
  end.