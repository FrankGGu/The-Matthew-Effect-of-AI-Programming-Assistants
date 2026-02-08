-module(solution).
-export([sellingPieces/2]).

sellingPieces(N, Cuts) ->
    sellingPieces(N, Cuts, 0).

sellingPieces(0, _, Max) -> 
    Max;
sellingPieces(Length, Cuts, Max) ->
    NewMax = lists:max([Max | lists:map(fun(Cut) -> sellingPieces(Length - Cut, Cuts, Max) end, Cuts)]),
    sellingPieces(Length - 1, Cuts, NewMax).