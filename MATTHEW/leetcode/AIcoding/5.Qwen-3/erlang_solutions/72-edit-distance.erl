-module(edit_distance).
-export([min_distance/2]).

min_distance(A, B) ->
    LenA = length(A),
    LenB = length(B),
    DP = array:new(LenA + 1, {default, 0}),
    DP1 = array:set(0, 0, DP),
    min_distance(A, B, LenA, LenB, DP1).

min_distance(_, _, 0, LenB, DP) ->
    array:get(LenB, DP);
min_distance(_, _, LenA, 0, DP) ->
    array:get(LenA, DP);
min_distance([H|T], B, LenA, LenB, DP) ->
    DP1 = array:set(1, LenA, DP),
    min_distance_helper(T, B, H, 1, LenA, LenB, DP1).

min_distance_helper([], _, _, _, _, _, DP) ->
    array:get(LenA, DP);
min_distance_helper([H|T], B, CurrChar, I, LenA, LenB, DP) ->
    J = 1,
    min_distance_helper_2(B, CurrChar, I, J, LenA, LenB, DP, T).

min_distance_helper_2([], _, _, _, _, _, DP, _) ->
    DP;
min_distance_helper_2([H|T], CurrChar, I, J, LenA, LenB, DP, Rest) ->
    Cost = if H == CurrChar -> 0; true -> 1 end,
    Top = array:get(I - 1, DP),
    Left = array:get(I, DP),
    Diag = array:get(I - 1, array:subarray(DP, J - 1, 1)),
    Current = min(Top + 1, Left + 1, Diag + Cost),
    DP1 = array:set(J, Current, DP),
    min_distance_helper_2(T, CurrChar, I, J + 1, LenA, LenB, DP1, Rest).

min_distance_helper_2([], _, _, _, _, _, DP, _) ->
    DP.

min(X, Y, Z) when X < Y -> min(X, Z);
min(X, Y, Z) when Y < Z -> min(Y, Z);
min(X, Y, Z) -> min(X, Y).

min(X, Y) when X < Y -> X;
min(X, Y) -> Y.