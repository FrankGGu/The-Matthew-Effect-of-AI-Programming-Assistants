-module(large_group_positions).
-export([large_group_positions/1]).

large_group_positions(S) ->
  large_group_positions(S, 0, 0, []).

large_group_positions([], Start, Count, Acc) ->
  case Count >= 3 of
    true -> lists:reverse([[Start, Start + Count - 1] | Acc]);
    false -> lists:reverse(Acc)
  end;

large_group_positions([H|T], Start, 0, Acc) ->
  large_group_positions(T, Start, 1, Acc);

large_group_positions([H|T], Start, Count, Acc) ->
  case H =:= lists:nth(Count, string:chars(S, [unicode])) of
    true -> large_group_positions(T, Start, Count + 1, Acc);
    false ->
      case Count >= 3 of
        true -> large_group_positions(T, Count + Start -1, 1, [[Start, Start + Count - 1] | Acc]);
        false -> large_group_positions(T, Count + Start -1, 1, Acc)
      end
  end.