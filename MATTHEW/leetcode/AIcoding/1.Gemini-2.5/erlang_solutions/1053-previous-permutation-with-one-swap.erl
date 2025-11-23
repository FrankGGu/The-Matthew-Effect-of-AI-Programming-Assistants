-module(solution).
-export([prevPermOpt1/1]).

prevPermOpt1(A) ->
    N = length(A),
    if N =< 1 ->
        A;
    true ->
        Arr = array:from_list(A),
        {IPivot, JSwap} = find_pivot_and_swap_indices(Arr, N),
        if IPivot == -1 ->
            A;
        true ->
            ValI = array:get(IPivot, Arr),
            ValJ = array:get(JSwap, Arr),
            Arr1 = array:set(IPivot, ValJ, Arr),
            Arr2 = array:set(JSwap, ValI, Arr1),
            array:to_list(Arr2)
        end
    end.

find_pivot_and_swap_indices(Arr, N) ->
    IPivot = find_i_pivot(Arr, N),
    if IPivot == -1 ->
        {-1, -1};
    true ->
        JSwap = find_j_swap(Arr, N, IPivot),
        {IPivot, JSwap}
    end.

find_i_pivot(Arr, N) ->
    find_i_pivot_loop(N - 2, Arr, N).

find_i_pivot_loop(I, Arr, N) ->
    if I < 0 ->
        -1; % No pivot found
    true ->
        FoundJ = find_any_j_for_i(I, Arr, N),
        if FoundJ /= -1 ->
            I; % This is the largest i that has a valid j
        true ->
            find_i_pivot_loop(I - 1, Arr, N)
        end
    end.

find_any_j_for_i(I, Arr, N) ->
    find_any_j_for_i_loop(N - 1, I, Arr, N).

find_any_j_for_i_loop(J, I, Arr, N) ->
    if J =< I ->
        -1; % No valid J found for this I
    true ->
        ValI = array:get(I, Arr),
        ValJ = array:get(J, Arr),
        if ValJ < ValI ->
            J; % Found a valid J for this I
        true ->
            find_any_j_for_i_loop(J - 1, I, Arr, N)
        end
    end.

find_j_swap(Arr, N, IPivot) ->
    TargetVal = array:get(IPivot, Arr),
    find_j_swap_loop(IPivot + 1, N - 1, Arr, TargetVal, -1, -1).

find_j_swap_loop(K, MaxK, Arr, TargetVal, BestJIdx, MaxValLessThanTarget) ->
    if K > MaxK ->
        BestJIdx;
    true ->
        ValK = array:get(K, Arr),
        if ValK < TargetVal ->
            if ValK > MaxValLessThanTarget ->
                find_j_swap_loop(K + 1, MaxK, Arr, TargetVal, K, ValK);
            else % ValK =< MaxValLessThanTarget. If equal, keep smaller index (current BestJIdx)
                find_j_swap_loop(K + 1, MaxK, Arr, TargetVal, BestJIdx, MaxValLessThanTarget)
            end;
        true -> % ValK >= TargetVal
            find_j_swap_loop(K + 1, MaxK, Arr, TargetVal, BestJIdx, MaxValLessThanTarget)
        end
    end.