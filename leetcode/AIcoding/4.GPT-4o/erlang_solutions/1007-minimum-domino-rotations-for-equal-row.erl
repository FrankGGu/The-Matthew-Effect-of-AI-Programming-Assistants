-module(solution).
-export([min_domino_rotations/3]).

min_domino_rotations(A, B, V) ->
    F1 = count_rotations(A, B, V, 0),
    F2 = count_rotations(B, A, V, 0),
    case {F1, F2} of
        {infinity, infinity} -> -1;
        {F1, _} when F1 =/= infinity -> F1;
        {_, F2} when F2 =/= infinity -> F2
    end.

count_rotations([], [], _, Rotations) -> Rotations;
count_rotations([A | As], [B | Bs], V, Rotations) ->
    case {A, B} of
        {V, _} -> count_rotations(As, Bs, V, Rotations);
        {_, V} -> count_rotations(As, Bs, V, Rotations);
        _ -> 
            case {A, B} of
                {X, Y} when X =/= Y -> infinity;
                _ -> count_rotations(As, Bs, V, Rotations + 1)
            end
    end.

infinity() -> 1000000.