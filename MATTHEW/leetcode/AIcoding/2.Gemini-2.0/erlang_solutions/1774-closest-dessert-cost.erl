-module(closest_dessert_cost).
-export([closest_cost/3]).

closest_cost(BaseCosts, ToppingCosts, Target) ->
  closest_cost(BaseCosts, ToppingCosts, Target, math:pow(2,31)-1).

closest_cost(BaseCosts, ToppingCosts, Target, Closest) ->
  lists:foldl(fun(BaseCost, Acc) ->
                  closest_cost_helper(ToppingCosts, Target, Acc, BaseCost)
              end, Closest, BaseCosts).

closest_cost_helper([], Target, Closest, CurrentCost) ->
  Diff1 = abs(Target - Closest),
  Diff2 = abs(Target - CurrentCost),
  if Diff2 < Diff1 orelse (Diff2 == Diff1 andalso CurrentCost < Closest) then
    CurrentCost
  else
    Closest
  end;
closest_cost_helper([ToppingCost | Rest], Target, Closest, CurrentCost) ->
  NewClosest1 = closest_cost_helper(Rest, Target, Closest, CurrentCost),
  NewClosest2 = closest_cost_helper(Rest, Target, NewClosest1, CurrentCost + ToppingCost),
  closest_cost_helper(Rest, Target, NewClosest2, CurrentCost + 2 * ToppingCost).