-module(solution).
-export([find_length/1]).

find_length(A) ->
    N = length(A),
    Left = find_left(A, N),
    Right = find_right(A, N),
    case Left of
        0 -> 0;
        _ -> 
            case Right of
                N -> 0;
                _ -> 
                    Min = min(Left, N - Right),
                    Max = max(Left, N - Right),
                    Result = N - Max,
                    if
                        Result < 0 -> 0;
                        true -> Result
                    end
            end
    end.

find_left(A, N) ->
    find_left(A, 0, 1, 0).

find_left(_, _, N, Acc) -> Acc;
find_left(A, I, J, Acc) ->
    if
        J >= N -> Acc;
        A--I < A--J -> find_left(A, J, J + 1, J);
        true -> find_left(A, I, J + 1, Acc)
    end.

find_right(A, N) ->
    find_right(A, N - 1, N - 2, N - 1).

find_right(_, _, -1, Acc) -> Acc;
find_right(A, I, J, Acc) ->
    if
        J < 0 -> Acc;
        A--J < A--I -> find_right(A, J, J - 1, J);
        true -> find_right(A, I, J - 1, Acc)
    end.