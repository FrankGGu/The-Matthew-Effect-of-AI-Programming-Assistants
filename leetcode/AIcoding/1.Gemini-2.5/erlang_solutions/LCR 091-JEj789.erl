-module(solution).
-export([minCost/1]).

minCost(Costs) ->
    case Costs of
        [] -> 0;
        [House1Costs | RestCosts] ->
            [R1, B1, G1] = House1Costs,
            dp(RestCosts, R1, B1, G1)
    end.

dp([], PrevRedCost, PrevBlueCost, PrevGreenCost) ->
    min(PrevRedCost, min(PrevBlueCost, PrevGreenCost));
dp([CurrentHouseCosts | RestCosts], PrevRedCost, PrevBlueCost, PrevGreenCost) ->
    [CurrR, CurrB, CurrG] = CurrentHouseCosts,

    NewRedCost = CurrR + min(PrevBlueCost, PrevGreenCost),
    NewBlueCost = CurrB + min(PrevRedCost, PrevGreenCost),
    NewGreenCost = CurrG + min(PrevRedCost, PrevBlueCost),

    dp(RestCosts, NewRedCost, NewBlueCost, NewGreenCost).