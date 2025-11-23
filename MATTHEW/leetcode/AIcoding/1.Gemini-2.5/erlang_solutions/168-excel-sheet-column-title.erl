-module(solution).
-export([columnTitle/1]).

columnTitle(N) ->
    columnTitle_acc(N, []).

columnTitle_acc(0, Acc) ->
    lists:reverse(Acc);
columnTitle_acc(N, Acc) ->
    Rem = (N - 1) rem 26,
    Char = $A + Rem,
    NewN = (N - 1) div 26,
    columnTitle_acc(NewN, [Char | Acc]).