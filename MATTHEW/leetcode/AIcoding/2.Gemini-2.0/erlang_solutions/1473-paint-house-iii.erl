-module(paint_house_iii).
-export([min_cost/4]).

min_cost(Houses, Cost, M, N, Target) ->
  memo(Houses, Cost, M, N, Target).

memo(Houses, Cost, M, N, Target) ->
  dp(0, 0, 0, Houses, Cost, M, N, Target, dict:new()).

dp(Index, Neighborhood, LastColor, Houses, Cost, M, N, Target, Memo) ->
  case dict:find({Index, Neighborhood, LastColor}, Memo) of
    {ok, Value} ->
      Value;
    error ->
      case Index of
        M ->
          if Neighborhood =:= Target then
            0
          else
            infinity
          end;
        _ ->
          case lists:nth(Index + 1, Houses) of
            0 ->
              Costs = [
                {C, dp(Index + 1, Neighborhood + (if C /= LastColor then 1 else 0), C, Houses, Cost, M, N, Target, Memo) + lists:nth(Index + 1, lists:nth(C,Cost))}
                || C <- lists:seq(1,N)
              ],
              MinCost = lists:min([CostVal || {_,CostVal} <- Costs]),
              dict:store({Index, Neighborhood, LastColor}, MinCost, Memo),
              MinCost;
            Color ->
              NewNeighborhood = Neighborhood + (if Color /= LastColor then 1 else 0),
              CostVal = dp(Index + 1, NewNeighborhood, Color, Houses, Cost, M, N, Target, Memo),
              dict:store({Index, Neighborhood, LastColor}, CostVal, Memo),
              CostVal
          end
      end
  end.

infinity() ->
  16#3f3f3f3f.