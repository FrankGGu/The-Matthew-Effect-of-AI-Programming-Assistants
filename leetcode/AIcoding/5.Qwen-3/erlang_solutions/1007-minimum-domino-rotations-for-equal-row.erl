-module(min_domino_rotations).
-export([min_domino_rotations/1]).

min_domino_rotations(Values) ->
    min_domino_rotations(Values, 0, 0, 0, 0).

min_domino_rotations([], A, B, C, D) ->
    case {A < B, C < D} of
        {true, true} -> min(A, C);
        {true, false} -> A;
        {false, true} -> C;
        {false, false} -> min(A, C)
    end;

min_domino_rotations([[A,B] | T], A1, B1, C1, D1) ->
    NewA = if A == A1 -> A1; true -> 0 end,
    NewB = if B == B1 -> B1; true -> 0 end,
    NewC = if A == C1 -> C1; true -> 0 end,
    NewD = if B == D1 -> D1; true -> 0 end,
    min_domino_rotations(T, NewA, NewB, NewC, NewD).