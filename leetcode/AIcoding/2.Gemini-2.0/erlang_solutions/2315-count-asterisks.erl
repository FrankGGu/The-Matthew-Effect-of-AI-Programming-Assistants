-module(count_asterisks).
-export([count_asterisks/1]).

count_asterisks(S) ->
  count_asterisks_helper(S, 0, true, 0).

count_asterisks_helper([], Count, _, Acc) ->
  Acc;
count_asterisks_helper([H|T], Count, InsidePair, Acc) ->
  case H of
    $| ->
      count_asterisks_helper(T, Count + 1, not InsidePair, Acc);
    $* ->
      case InsidePair of
        true ->
          count_asterisks_helper(T, Count, InsidePair, Acc + 1);
        false ->
          count_asterisks_helper(T, Count, InsidePair, Acc)
      end;
    _ ->
      count_asterisks_helper(T, Count, InsidePair, Acc)
  end.