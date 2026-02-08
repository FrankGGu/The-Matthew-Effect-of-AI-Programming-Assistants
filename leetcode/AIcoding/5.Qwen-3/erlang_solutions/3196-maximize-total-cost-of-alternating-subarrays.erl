-module(maximize_total_cost_of_alternating_subarrays).
-export([maxTotalCost/1]).

maxTotalCost(Costs) ->
    maxTotalCost(Costs, 0, 0, 0).

maxTotalCost([], _, _, Acc) ->
    Acc;
maxTotalCost([H | T], Index, State, Acc) ->
    case State of
        0 ->
            NewAcc = Acc + H,
            maxTotalCost(T, Index + 1, 1, NewAcc);
        1 ->
            NewAcc = Acc + H,
            maxTotalCost(T, Index + 1, 0, NewAcc)
    end.