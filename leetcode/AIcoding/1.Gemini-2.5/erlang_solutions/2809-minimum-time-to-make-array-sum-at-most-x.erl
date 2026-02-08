-spec min_cost(Nums :: [integer()], Costs :: [integer()], X :: integer()) -> integer().
min_cost(Nums, Costs, X) ->
    S_total = lists:sum(Nums),

    if S_total =< X ->
        0;
    X < 0 ->
        -1;
    true ->
        R = S_total - X,

        % Create a flat list of all individual costs.
        % For each num_i, cost_i pair, we have num_i units of reduction, each costing cost_i.
        % Example: Nums = [2, 1], Costs = [10, 5]
        % lists:zip(Nums, Costs) -> [{2,10}, {1,5}]
        % lists:flatmap(fun({Count, Cost}) -> lists:duplicate(Count, Cost) end, lists:zip(Nums, Costs))
        %   -> lists:duplicate(2, 10) ++ lists:duplicate(1, 5)
        %   -> [10, 10] ++ [5] -> [10, 10, 5]
        AllCosts = lists:flatmap(fun({Count, Cost}) -> lists:duplicate(Count, Cost) end, lists:zip(Nums, Costs)),

        % Sort all available costs in ascending order to pick the cheapest ones first.
        SortedCosts = lists:sort(AllCosts),

        % Take the first R elements (cheapest reductions) and sum their costs.
        lists:sum(lists:sublist(SortedCosts, R))
    end.