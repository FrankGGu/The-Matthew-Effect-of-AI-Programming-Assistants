-module(water_bottles).
-export([num_water_bottles/2]).

num_water_bottles(NumBottles, NumExchange) ->
    num_water_bottles(NumBottles, NumExchange, 0).

num_water_bottles(0, _, _) ->
    0;
num_water_bottles(NumBottles, NumExchange, Empty) ->
    Full = NumBottles,
    Drink = Full,
    NewEmpty = Empty + Full,
    NewNumBottles = NewEmpty div NumExchange,
    num_water_bottles(NewNumBottles, NumExchange, NewEmpty rem NumExchange) + Drink.