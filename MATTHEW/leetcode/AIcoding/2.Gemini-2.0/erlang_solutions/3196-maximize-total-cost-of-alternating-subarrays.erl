-module(maximize_cost).
-export([maximize_alternating_cost/1]).

maximize_alternating_cost(Nums) ->
  maximize_alternating_cost(Nums, 0, 0, true).

maximize_alternating_cost([], Cost, _, _) ->
  Cost;
maximize_alternating_cost([H|T], Cost, Prev, IsPositive) ->
  case IsPositive of
    true ->
      case Prev > 0 of
        true ->
          maximize_alternating_cost(T, Cost + max(0, H - Prev), H, false);
        false ->
          maximize_alternating_cost(T, Cost + H, H, false)
      end;
    false ->
      case Prev > 0 of
        true ->
          maximize_alternating_cost(T, Cost + max(0, Prev - H), H, true);
        false ->
          maximize_alternating_cost(T, Cost + abs(H), H, true)
      end
  end.