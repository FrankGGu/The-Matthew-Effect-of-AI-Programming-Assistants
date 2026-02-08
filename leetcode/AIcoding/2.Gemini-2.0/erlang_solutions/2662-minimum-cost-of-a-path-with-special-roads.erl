-module(minimum_cost_special_roads).
-export([minimum_cost/6]).

minimum_cost(Start, Target, SpecialRoads) ->
  minimum_cost(Start, Target, SpecialRoads, #{Start => 0}).

minimum_cost(_Start, Target, _SpecialRoads, Costs) when map_get(Target, Costs, undefined) /= undefined ->
  map_get(Target, Costs);
minimum_cost(Start, Target, SpecialRoads, Costs) ->
  {X1, Y1} = Start,
  {X2, Y2} = Target,
  DefaultCost = map_get(Target, Costs, infinity),
  NewCosts = maps:put(Target, min(DefaultCost, map_get(Start, Costs, 0) + abs(X1 - X2) + abs(Y1 - Y2)), Costs),
  NewCosts2 = lists:foldl(
    fun(SR, AccCosts) ->
      {SX1, SY1, SX2, SY2, Cost} = SR,
      SCost1 = map_get({SX1, SY1}, AccCosts, infinity),
      SCost2 = map_get({SX2, SY2}, AccCosts, infinity),
      if
        SCost1 /= infinity ->
          AccCosts2 = maps:put({SX2, SY2}, min(SCost2, SCost1 + Cost), AccCosts),
          AccCosts2;
        true ->
          AccCosts
      end
    end,
    NewCosts,
    SpecialRoads
  ),

  NewCosts3 = lists:foldl(
    fun(SR, AccCosts) ->
      {SX1, SY1, SX2, SY2, Cost} = SR,
      SCost1 = map_get({SX1, SY1}, AccCosts, infinity),
      SCost2 = map_get({SX2, SY2}, AccCosts, infinity),
      if
        SCost2 /= infinity ->
          AccCosts2 = maps:put({SX1, SY1}, min(SCost1, SCost2 + abs(SX1 - SX2) + abs(SY1 - SY2) - Cost), AccCosts),
          AccCosts2;
        true ->
          AccCosts
      end
    end,
    NewCosts2,
    SpecialRoads
  ),

  minimum_cost(Start, Target, SpecialRoads, NewCosts3).