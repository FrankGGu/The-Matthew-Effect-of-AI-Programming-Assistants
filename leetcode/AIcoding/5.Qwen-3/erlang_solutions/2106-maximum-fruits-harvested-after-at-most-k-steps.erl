-module(max_fruits_harvested_after_at_most_k_steps).
-export([max_total_fruits/2]).

max_total_fruits(Fruits, K) ->
    N = length(Fruits),
    MaxFruits = 0,
    max_total_fruits(Fruits, K, 0, N-1, MaxFruits).

max_total_fruits(_, _, Left, Right, Acc) when Left > Right ->
    Acc;
max_total_fruits(Fruits, K, Left, Right, Acc) ->
    CurrentFruits = lists:sum(lists:sublist(Fruits, Left+1, Right-Left+1)),
    NewAcc = max(Acc, CurrentFruits),
    case Left of
        0 -> max_total_fruits(Fruits, K, Left+1, Right, NewAcc);
        _ -> max_total_fruits(Fruits, K, Left, Right-1, NewAcc)
    end.