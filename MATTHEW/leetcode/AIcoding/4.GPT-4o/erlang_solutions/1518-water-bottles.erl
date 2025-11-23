-module(solution).
-export([num_water_bottles/2]).

num_water_bottles(needed, exchange) ->
    total = needed,
    bottles = needed,
    loop(bottles, exchange, total).

loop(Bottles, Exchange, Total) when Bottles > 0 ->
    NewBottles = Bottles div Exchange,
    Remaining = Bottles rem Exchange,
    Total1 = Total + NewBottles,
    loop(NewBottles + Remaining, Exchange, Total1);
loop(_, _, Total) ->
    Total.