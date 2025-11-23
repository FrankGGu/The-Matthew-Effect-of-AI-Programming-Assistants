-module(solution).
-export([cut_wood/2]).

cut_wood(N, L) ->
    cut_wood(N, L, 0).

cut_wood(0, _, Acc) -> Acc;
cut_wood(N, L, Acc) ->
    New_Acc = Acc + 1,
    cut_wood(N - L, L, New_Acc).