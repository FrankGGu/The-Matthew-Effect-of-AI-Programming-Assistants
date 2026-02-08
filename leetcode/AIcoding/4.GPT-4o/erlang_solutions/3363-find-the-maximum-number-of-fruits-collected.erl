-module(solution).
-export([max_fruits/1]).

max_fruits(Fruits) ->
    MaxFruits = lists:foldl(fun({Count, _}, Acc) -> Acc + Count end, 0, Fruits),
    MaxFruits.