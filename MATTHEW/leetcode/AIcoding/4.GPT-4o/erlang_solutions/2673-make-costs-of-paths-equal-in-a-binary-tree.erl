-module(solution).
-export([min_cost/1]).

-record(node, {val, left = none, right = none}).

min_cost(Root) ->
    {Min, _} = min_cost_helper(Root),
    Min.

min_cost_helper(none) ->
    {0, 0};
min_cost_helper(#node{val = Val, left = Left, right = Right}) ->
    {LMin, LCost} = min_cost_helper(Left),
    {RMin, RCost} = min_cost_helper(Right),
    TotalCost = LCost + RCost,
    Min = min(LMin + abs(Val - LMin), RMin + abs(Val - RMin)),
    {Min, TotalCost + Val}.