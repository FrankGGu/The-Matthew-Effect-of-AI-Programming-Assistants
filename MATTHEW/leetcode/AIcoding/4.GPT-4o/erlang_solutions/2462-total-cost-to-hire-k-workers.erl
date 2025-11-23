-module(solution).
-export([totalCost/3]).

totalCost(Costs, K, C) ->
    SortedCosts = lists:sort(Costs),
    total_cost(SortedCosts, K, C, 0, 0).

total_cost(_, 0, _, Acc, _) -> Acc;
total_cost(Costs, K, C, Acc, Count) when Count < K ->
    case lists:split(K, Costs) of
        {H, _} ->
            total_cost(H, K - 1, C, Acc + hd(H), Count + 1);
    end;
total_cost(Costs, K, C, Acc, Count) ->
    case lists:split(Count, Costs) of
        {H, T} ->
            case T of
                [] -> Acc;
                [Next | _] ->
                    total_cost([Next | H], K, C, Acc + Next, Count + 1)
            end
    end.