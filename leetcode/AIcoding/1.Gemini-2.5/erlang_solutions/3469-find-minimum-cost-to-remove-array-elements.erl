-module(solution).
-export([minCost/1]).

minCost(Nums) ->
    % Sort the numbers in descending order.
    % The strategy to minimize cost is to multiply larger numbers by smaller multipliers.
    % The multipliers increase with each element removed.
    % So, the largest element should be multiplied by 1, the second largest by 2, and so on.
    SortedNumsDesc = lists:reverse(lists:sort(Nums)),

    % Calculate the total cost by iterating through the sorted list
    % and multiplying each element by its removal order (1-indexed).
    calculate_cost(SortedNumsDesc, 1, 0).

calculate_cost([], _K, Acc) ->
    Acc;
calculate_cost([H|T], K, Acc) ->
    calculate_cost(T, K + 1, Acc + (H * K)).