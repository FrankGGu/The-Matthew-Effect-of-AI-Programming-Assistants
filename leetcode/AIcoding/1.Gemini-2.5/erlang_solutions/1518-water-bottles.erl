-module solution.
-export([water_bottles/2]).

water_bottles(NumBottles, NumExchange) ->
    solve(NumBottles, NumBottles, NumExchange).

solve(DrunkCount, EmptyBottles, NumExchange) when EmptyBottles < NumExchange ->
    DrunkCount;
solve(DrunkCount, EmptyBottles, NumExchange) ->
    NewFullBottles = EmptyBottles div NumExchange,
    RemainingEmpty = EmptyBottles rem NumExchange,
    TotalEmptyAfterExchange = RemainingEmpty + NewFullBottles,
    solve(DrunkCount + NewFullBottles, TotalEmptyAfterExchange, NumExchange).