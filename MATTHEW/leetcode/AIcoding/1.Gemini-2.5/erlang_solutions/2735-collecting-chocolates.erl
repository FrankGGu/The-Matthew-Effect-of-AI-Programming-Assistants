-module(solution).
-export([collectingChocolates/2]).

collectingChocolates(Costs, X) ->
    N = length(Costs),
    OriginalCostsTuple = list_to_tuple(Costs),

    CurrentModifiedCosts = Costs,
    MinTotalCost = lists:sum(Costs),

    loop_k(1, N, X, OriginalCostsTuple, CurrentModifiedCosts, MinTotalCost).

loop_k(K_val, N, X, OriginalCostsTuple, CurrentModifiedCosts, MinTotalCost) ->
    if K_val >= N ->
        MinTotalCost;
    else
        CostOfRotations = K_val * X,
        {NewModifiedCosts, NewSum} = calculate_next_modified_costs(K_val, CurrentModifiedCosts, OriginalCostsTuple, N),
        UpdatedMinTotalCost = min(MinTotalCost, NewSum + CostOfRotations),
        loop_k(K_val + 1, N, X, OriginalCostsTuple, NewModifiedCosts, UpdatedMinTotalCost)
    end.

calculate_next_modified_costs(K_val, CurrentModCosts, OriginalCostsTuple, N) ->
    calculate_next_modified_costs_acc(0, CurrentModCosts, OriginalCostsTuple, N, K_val, [], 0).

calculate_next_modified_costs_acc(Index, [], _OriginalCostsTuple, _N, _K_val, AccNewModCostsReversed, AccNewSum) ->
    {lists:reverse(AccNewModCostsReversed), AccNewSum};
calculate_next_modified_costs_acc(Index, [ValJ | RestCurrentModCosts], OriginalCostsTuple, N, K_val, AccNewModCostsReversed, AccNewSum) ->
    ValJK = element((Index + K_val) rem N + 1, OriginalCostsTuple),
    NewValJ = min(ValJ, ValJK),
    calculate_next_modified_costs_acc(Index + 1, RestCurrentModCosts, OriginalCostsTuple, N, K_val, [NewValJ | AccNewModCostsReversed], AccNewSum + NewValJ).