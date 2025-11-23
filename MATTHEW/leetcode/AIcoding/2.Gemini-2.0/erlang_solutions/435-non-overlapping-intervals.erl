-module(non_overlapping_intervals).
-export([erase_overlap_intervals/1]).

erase_overlap_intervals(Intervals) ->
  erase_overlap_intervals(lists:sort(fun({A1, _}, {A2, _}) -> A1 < A2 end, Intervals), 0, -infinity).

erase_overlap_intervals([], Count, _) ->
  Count;
erase_overlap_intervals([{Start, End} | Rest], Count, PrevEnd) ->
  if
    Start >= PrevEnd ->
      erase_overlap_intervals(Rest, Count, End);
    true ->
      erase_overlap_intervals(Rest, Count + 1, PrevEnd)
  end.