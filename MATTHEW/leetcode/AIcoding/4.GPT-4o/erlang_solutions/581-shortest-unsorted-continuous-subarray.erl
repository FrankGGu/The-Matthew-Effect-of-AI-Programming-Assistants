-module(solution).
-export([findUnsortedSubarray/1]).

findUnsortedSubarray(A) ->
    N = length(A),
    {Start, End} = find_boundaries(A, N, 0, N - 1),
    if
        Start >= End -> 0
        true -> End - Start + 1
    end.

find_boundaries(A, N, Start, End) ->
    case {find_start(A, N, Start), find_end(A, N, End)} of
        {S, E} when S < E -> {S, E}
        {S, E} -> {N, -1}
    end.

find_start(A, N, Index) when Index < N - 1 ->
    case A[Index] > A[Index + 1] of
        true -> Index
        false -> find_start(A, N, Index + 1)
    end;
find_start(_, N, Index) -> N.

find_end(A, N, Index) when Index > 0 ->
    case A[Index] < A[Index - 1] of
        true -> Index
        false -> find_end(A, N, Index - 1)
    end;
find_end(_, 0, Index) -> -1.