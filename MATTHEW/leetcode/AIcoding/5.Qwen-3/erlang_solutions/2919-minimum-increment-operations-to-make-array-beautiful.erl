-module(solution).
-export([minIncrementToMakeBeautiful/2]).

minIncrementToMakeBeautiful(A, K) ->
    N = length(A),
    Sorted = lists:sort(A),
    minIncrementToMakeBeautiful(Sorted, K, 0, 0).

minIncrementToMakeBeautiful([], _, _, Acc) ->
    Acc;
minIncrementToMakeBeautiful([H | T], K, Pos, Acc) ->
    Target = H + (Pos rem K),
    NewAcc = Acc + (Target - H),
    minIncrementToMakeBeautiful(T, K, Pos + 1, NewAcc).