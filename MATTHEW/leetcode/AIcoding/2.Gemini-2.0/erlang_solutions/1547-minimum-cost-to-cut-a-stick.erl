-module(minimum_cost_to_cut_stick).
-export([min_cost/2]).

min_cost(N, Cuts) ->
  Cuts1 = lists:sort(Cuts),
  Cuts2 = [0 | Cuts1 ++ [N]],
  Len = length(Cuts2),
  Memo = array:new([{size,{Len, Len}}, {default, -1}]),
  min_cost_helper(Cuts2, 1, Len - 2, Memo).

min_cost_helper(Cuts, L, R, Memo) ->
  case array:get({L, R}, Memo) of
    -1 ->
      case L > R of
        true ->
          0;
        false ->
          Costs = [min_cost_helper(Cuts, L, I - 1, Memo) + min_cost_helper(Cuts, I + 1, R, Memo) + lists:nth(L-1, Cuts) + lists:nth(R+1, Cuts) || I <- lists:seq(L, R)],
          MinCost = lists:min(Costs),
          array:set({L, R}, MinCost, Memo),
          MinCost
      end;
    Value ->
      Value
  end.