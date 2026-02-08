-module(solution).
-export([triangleNumber/1]).

-include_lib("array/include/array.hrl").

triangleNumber(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    case N of
        N when N < 3 -> 0;
        _ ->
            Array = array:from_list(SortedNums),
            solve_i(Array, N, 0, 0)
    end.

solve_i(Array, N, I, Count) when I < N - 2 ->
    A = array:get(I, Array),
    % K is the right pointer, starting at I + 2 (0-indexed)
    solve_j(Array, N, I, A, I + 1, I + 2, Count);
solve_i(_Array, _N, _I, Count) ->
    Count. % Base case for I loop

solve_j(Array, N, I, A, J, K, CurrentCount) when J < N - 1 ->
    B = array:get(J, Array),
    TargetSum = A + B,

    % Move K pointer
    NewK = find_k(Array, N, K, TargetSum),

    % Add valid triangles for this (A, B) pair
    % The number of valid C's is (NewK - 1) - (J + 1) + 1 = NewK - 1 - J
    AddedCount = NewK - 1 - J,

    NextCount = CurrentCount + AddedCount,

    solve_j(Array, N, I, A, J + 1, NewK, NextCount); % Increment J, keep K
solve_j(Array, N, I, _A, _J, _K, CurrentCount) ->
    % J loop finished, move to next I
    solve_i(Array, N, I + 1, CurrentCount).

find_k(Array, N, CurrentK, TargetSum) when CurrentK < N ->
    C = array:get(CurrentK, Array),
    if C < TargetSum ->
        find_k(Array, N, CurrentK + 1, TargetSum);
       true ->
        CurrentK % Found the first element >= TargetSum
    end;
find_k(_Array, N, N, _TargetSum) ->
    N. % Reached end of array