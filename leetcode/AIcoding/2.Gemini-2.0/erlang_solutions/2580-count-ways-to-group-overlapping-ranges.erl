-module(solution).
-export([solve/1]).

solve(Ranges) ->
  SortedRanges = lists:sort(Ranges),
  fold_ranges(SortedRanges, []).

fold_ranges([], Acc) ->
  length(Acc) rem (1000000000 + 7);
fold_ranges([H|T], Acc) ->
  case Acc of
    [] ->
      fold_ranges(T, [H]);
    [Last] ->
      [Start1, End1] = H,
      [Start2, End2] = Last,
      if
        Start1 =< End2 ->
          fold_ranges(T, [[Start2, max(End1, End2)]]);
        true ->
          fold_ranges(T, [Last, H])
      end
  end.