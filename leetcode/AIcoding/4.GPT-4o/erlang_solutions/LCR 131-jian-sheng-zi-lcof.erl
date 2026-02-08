-module(solution).
-export([cut_wood/1]).

cut_wood(Height) ->
    cut_wood(Height, 0).

cut_wood(0, Acc) -> 
    Acc;
cut_wood(Height, Acc) ->
    cut_wood(Height - 1, Acc + Height).