-module(total_cost_to_hire_k_workers).
-export([totalCostToHireKWorkers/2]).

totalCostToHireKhire/2(Workers, K) ->
    lists:foldl(fun(_I, Acc) -> 
        {Min1, Min2, Rest} = find_min_pair(Acc),
        Acc + Min1 + Min2
    end, 0, lists:seq(1, K)).

find_min_pair({[], []}) ->
    {0, 0, []};
find_min_pair({[H|T], [H2|T2]}) ->
    {H, H2, {T, T2}}.

totalCostToHireKWorkers(Costs, K) ->
    Sorted = lists:sort(Costs),
    totalCostToHireKWorkers(Sorted, K, 0, 0, 0).

totalCostToHireKWorkers(_, 0, _, _, Total) ->
    Total;
totalCostToHireKWorkers([H|T], K, Left, Right, Total) ->
    if
        Left < Right ->
            totalCostToHireKWorkers(T, K-1, Left+1, Right, Total + H);
        true ->
            totalCostToHireKWorkers(T, K-1, Left, Right+1, Total + H)
    end.