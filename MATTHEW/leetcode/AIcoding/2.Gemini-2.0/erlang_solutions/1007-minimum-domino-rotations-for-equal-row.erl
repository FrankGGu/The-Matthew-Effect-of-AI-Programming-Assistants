-module(minimum_domino_rotations).
-export([minDominoRotations/2]).

minDominoRotations(A, B) ->
    len = length(A),
    try_val(A, B, A, len, 0) orelse try_val(A, B, B, len, 0).

try_val(A, B, Target, Len, Count) ->
    Val = lists:nth(1, Target),
    CountA = count_rotations(A, B, Val, Len, 0),
    CountB = count_rotations(B, A, Val, Len, 0),
    if CountA == -1 and CountB == -1 then
        -1
    else
        case {CountA, CountB} of
            {-1, C} -> C;
            {C, -1} -> C;
            {C1, C2} -> min(C1, C2)
        end
    end.

count_rotations(A, B, Val, Len, Count) ->
    count_rotations_helper(A, B, Val, Len, 1, Count).

count_rotations_helper(A, B, Val, Len, I, Count) ->
    if I > Len then
        Count
    else
        if lists:nth(I, A) == Val then
            count_rotations_helper(A, B, Val, Len, I + 1, Count)
        else
            if lists:nth(I, B) == Val then
                count_rotations_helper(A, B, Val, Len, I + 1, Count + 1)
            else
                -1
            end
        end
    end.