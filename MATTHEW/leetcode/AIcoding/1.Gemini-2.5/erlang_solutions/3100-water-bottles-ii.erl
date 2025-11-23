-module(solution).
-export([num_water_bottles/2]).

num_water_bottles(NumBottles, NumExchange) ->
    solve(NumBottles, NumBottles, NumExchange).

solve(TotalDrunk, EmptyBottles, NumExchange) when EmptyBottles >= NumExchange ->
    NewFullBottles = EmptyBottles div NumExchange,
    RemainingEmpty = EmptyBottles rem NumExchange,
    solve(TotalDrunk + NewFullBottles, RemainingEmpty + NewFullBottles, NumExchange);
solve(TotalDrunk, _EmptyBottles, _NumExchange) ->
    TotalDrunk.