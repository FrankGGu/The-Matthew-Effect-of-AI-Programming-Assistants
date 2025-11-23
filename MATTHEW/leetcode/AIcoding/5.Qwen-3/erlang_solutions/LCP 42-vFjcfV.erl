-module(toy_rings).
-export([find_even_numbers/1]).

find_even_numbers(Nums) ->
    lists:filter(fun(X) -> X rem 2 == 0 end, Nums).