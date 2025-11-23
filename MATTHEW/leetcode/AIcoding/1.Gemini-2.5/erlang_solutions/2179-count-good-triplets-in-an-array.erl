-module(solution).
-export([count_good_triplets/4]).

count_good_triplets(Arr, A, B, C) ->
    ArrTuple = list_to_tuple(Arr),
    N = tuple_size(ArrTuple),
    count_triplets_recursive(0, N, ArrTuple, A, B, C, 0).

count_triplets_recursive(I, N, ArrTuple, A, B, C, CurrentCount) when I < N - 2 ->
    ValI = element(I + 1, ArrTuple),
    NewCount = count_j_loop(I + 1, N, ArrTuple, A, B, C, ValI, CurrentCount),
    count_triplets_recursive(I + 1, N, ArrTuple, A, B, C, NewCount);
count_triplets_recursive(_I, _N, _ArrTuple, _A, _B, _C, CurrentCount) ->
    CurrentCount.

count_j_loop(J, N, ArrTuple, A, B, C, ValI, CurrentCount) when J < N - 1 ->
    ValJ = element(J + 1, ArrTuple),
    AbsIJ = abs(ValI - ValJ),
    NewCount = if AbsIJ =< A ->
                   count_k_loop(J + 1, N, ArrTuple, A, B, C, ValI, ValJ, CurrentCount);
               true ->
                   CurrentCount
               end,
    count_j_loop(J + 1, N, ArrTuple, A, B, C, ValI, NewCount);
count_j_loop(_J, _N, _ArrTuple, _A, _B, _C, _ValI, CurrentCount) ->
    CurrentCount.

count_k_loop(K, N, ArrTuple, A, B, C, ValI, ValJ, CurrentCount) when K < N ->
    ValK = element(K + 1, ArrTuple),
    AbsJK = abs(ValJ - ValK),
    AbsIK = abs(ValI - ValK),
    NewCount = if AbsJK =< B andalso AbsIK =< C ->
                   CurrentCount + 1;
               true ->
                   CurrentCount
               end,
    count_k_loop(K + 1, N, ArrTuple, A, B, C, ValI, ValJ, NewCount);
count_k_loop(_K, _N, _ArrTuple, _A, _B, _C, _ValI, _ValJ, CurrentCount) ->
    CurrentCount.