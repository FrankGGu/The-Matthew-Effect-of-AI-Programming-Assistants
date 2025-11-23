-module(solution).
-export([can_complete_circuit/2]).

can_complete_circuit(Gas, Cost) ->
    N = length(Gas),
    {StartIndex, _} = lists:foldl(fun({GasElem, CostElem}, {Index, Acc}) ->
        NewAcc = Acc + GasElem - CostElem,
        if NewAcc < 0 -> {Index + 1, 0}; true -> {Index, NewAcc} end
    end, {0, 0}, lists:zip(Gas, Cost)),
    if StartIndex >= N -> -1; true -> StartIndex end.