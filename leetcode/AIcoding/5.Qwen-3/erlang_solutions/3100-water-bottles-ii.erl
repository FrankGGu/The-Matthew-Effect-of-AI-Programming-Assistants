-module(water_bottles_ii).
-export([num_water_bottles/2]).

num_water_bottles(NumBottles, NumExchange) ->
    num_water_bottles(NumBottles, NumExchange, 0).

num_water_bottles(0, _, _) ->
    0;
num_water_bottles(NumBottles, NumExchange, Empty) ->
    Full = NumBottles,
    Used = Full,
    NewEmpty = Empty + Full,
    NewFull = NewEmpty div NumExchange,
    num_water_bottles(NewFull, NumExchange, NewEmpty rem NumExchange) + Used.