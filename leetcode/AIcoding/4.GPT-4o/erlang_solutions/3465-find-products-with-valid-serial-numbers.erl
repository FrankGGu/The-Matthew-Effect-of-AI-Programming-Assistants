-module(solution).
-export([find_products/1]).

find_products(Products) ->
    ValidSerials = lists:filter(fun(Serial) -> valid_serial(Serial) end, Products),
    lists:map(fun({Product, Serial}) -> Product end, ValidSerials).

valid_serial(Serial) ->
    re:run(Serial, "^[A-Z]{3}-[0-9]{3}-[A-Z]{3}$") =:= {match, _}.