-module(minimum_maximum_nodes).
-export([solve/1]).

solve(Head) ->
  solve(Head, null, 0, 1, [], []).

solve(null, _, _, _, MinDists, MaxDists) ->
  case length(MinDists) of
    0 -> [-1, -1];
    _ ->
      Min = lists:min(MinDists),
      Max = lists:max(MaxDists),
      [Min, Max]
  end;
solve(Node, Prev, PrevVal, Index, MinDists, MaxDists) ->
  Val = Node#node.val,
  Next = Node#node.next,
  case Prev of
    null ->
      solve(Next, Node, Val, Index + 1, MinDists, MaxDists);
    _ ->
      case Next of
        null ->
          solve(Next, Node, Val, Index + 1, MinDists, MaxDists);
        _ ->
          NextVal = Next#node.val,
          case is_critical_point(PrevVal, Val, NextVal) of
            true ->
              NewMinDists =
                case MinDists of
                  [] -> MinDists;
                  _ -> [lists:min(lists:map(fun(I) -> Index - I end, MinDists))]
                end,
              NewMaxDists =
                case MaxDists of
                  [] -> MaxDists;
                  _ -> [lists:max(lists:map(fun(I) -> Index - I end, MaxDists))]
                end,
              solve(Next, Node, Val, Index + 1, [Index | NewMinDists], [Index | NewMaxDists]);
            false ->
              solve(Next, Node, Val, Index + 1, MinDists, MaxDists)
          end
      end
  end.

is_critical_point(PrevVal, Val, NextVal) ->
  (Val < PrevVal and Val < NextVal) or (Val > PrevVal and Val > NextVal).