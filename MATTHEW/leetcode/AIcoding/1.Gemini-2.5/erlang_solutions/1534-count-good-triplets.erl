-module(solution).
-export([count_good_triplets/4]).

count_good_triplets(Arr, A, B, C) ->
    Len = length(Arr),
    count_triplets_i(Arr, A, B, C, Len, 0, 0).

count_triplets_i(Arr, A, B, C, Len, I, CurrentCount) when I =< Len - 3 ->
    NewCount = count_triplets_j(Arr, A, B, C, Len, I, I + 1, CurrentCount),
    count_triplets_i(Arr, A, B, C, Len, I + 1, NewCount);
count_triplets_i(_Arr, _A, _B, _C, _Len, _I, CurrentCount) ->
    CurrentCount.

count_triplets_j(Arr, A, B, C, Len, I, J, CurrentCount) when J =< Len - 2 ->
    NewCount = count_triplets_k(Arr, A, B, C, Len, I, J, J + 1, CurrentCount),
    count_triplets_j(Arr, A, B, C, Len, I, J + 1, NewCount);
count_triplets_j(_Arr, _A, _B, _C, _Len, _I, _J, CurrentCount) ->
    CurrentCount.

count_triplets_k(Arr, A, B, C, Len, I, J, K, CurrentCount) when K =< Len - 1 ->
    ValI = lists:nth(I + 1, Arr),
    ValJ = lists:nth(J + 1, Arr),
    ValK = lists:nth(K + 1, Arr),

    Condition1 = abs(ValI - ValJ) =< A,
    Condition2 = abs(ValJ - ValK) =< B,
    Condition3 = abs(ValI - ValK) =< C,

    NewCount = if
                   Condition1 and Condition2 and Condition3 -> CurrentCount + 1;
                   true -> CurrentCount
               end,
    count_triplets_k(Arr, A, B, C, Len, I, J, K + 1, NewCount);
count_triplets_k(_Arr, _A, _B, _C, _Len, _I, _J, _K, CurrentCount) ->
    CurrentCount.