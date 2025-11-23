-module(min_cost_climbing_stairs).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Cost) ->
  N = length(Cost),
  min_cost_climbing_stairs_helper(Cost, N, 0, 0).

min_cost_climbing_stairs_helper(_Cost, 0, Cost0, _Cost1) ->
  Cost0;
min_cost_climbing_stairs_helper(_Cost, 1, _Cost0, Cost1) ->
  Cost1;
min_cost_climbing_stairs_helper(Cost, N, Cost0, Cost1) ->
  CostN = lists:nth(N, Cost),
  NewCost0 = Cost1,
  NewCost1 = CostN + min(Cost0, Cost1),
  min_cost_climbing_stairs_helper(Cost, N - 1, NewCost0, NewCost1).

min_cost_climbing_stairs(Cost) ->
    N = length(Cost),
    DP = lists:duplicate(N + 1, 0),
    DP_fun = fun(I, D) ->
        case I of
            0 -> 0;
            1 -> 0;
            _ ->
                C1 = lists:nth(I - 1, Cost) + D !! (I - 1),
                C2 = lists:nth(I - 2, Cost) + D !! (I - 2),
                min(C1, C2)
        end
    end,
    DP_list = [DP_fun(I, DP) || I <- lists:seq(0, N)],
    lists:nth(N, DP_list).