-module(WeightedRandom).
-export([pick/1]).

pick(Weights) ->
    TotalWeight = lists:sum(Weights),
    RandomValue = random:uniform(TotalWeight),
    pick_index(Weights, RandomValue, 0).

pick_index([], _, _) -> -1;
pick_index([Weight | T], RandomValue, Acc) ->
    NewAcc = Acc + Weight,
    if
        RandomValue =< NewAcc -> length(Weights) - length(T)  % Calculate index
        true -> pick_index(T, RandomValue, NewAcc)
    end.