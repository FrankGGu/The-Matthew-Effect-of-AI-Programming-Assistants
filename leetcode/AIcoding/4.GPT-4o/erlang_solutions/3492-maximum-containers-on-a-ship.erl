-module(solution).
-export([maxContainers/2]).

maxContainers(Rows, MaxWeight) ->
    MaxContainers = lists:foldl(fun({Weight, _}, Acc) -> Acc + Weight end, 0, Rows),
    MaxWeightDiv = div(MaxWeight, 2),
    max_containers_helper(Rows, MaxWeightDiv, MaxContainers).

max_containers_helper([], _, Acc) -> Acc;
max_containers_helper([{Weight, Count} | Rest], MaxWeight, Acc) ->
    if
        Weight > MaxWeight -> max_containers_helper(Rest, MaxWeight, Acc);
        true -> 
            NewAcc = min(Acc + Count, MaxWeight div Weight),
            max_containers_helper(Rest, MaxWeight - Weight * NewAcc, NewAcc)
    end.