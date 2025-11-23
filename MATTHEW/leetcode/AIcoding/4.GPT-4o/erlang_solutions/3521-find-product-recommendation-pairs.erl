-module(solution).
-export([find_pairs/2]).

find_pairs(Products, Target) ->
    ProductsList = lists:map(fun({X, Y}) -> {X, Y} end, Products),
    Pairs = lists:filter(fun({X, Y}) -> X + Y =:= Target end, lists:flatmap(fun(X) -> lists:map(fun(Y) -> {X, Y} end, ProductsList) end, ProductsList)),
    lists:usort(Pairs).