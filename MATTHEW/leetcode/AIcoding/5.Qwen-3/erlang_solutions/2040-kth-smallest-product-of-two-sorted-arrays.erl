-module(kth_smallest_product).
-export([kthSmallestProduct/2]).

kthSmallestProduct(A, B) ->
    kthSmallestProduct(A, B, 1, 1, length(A), length(B), 0, 1, 1, 0).

kthSmallestProduct(_, _, _, _, _, _, L, R, _, K) when L >= R ->
    K;
kthSmallestProduct(A, B, left, right, lenA, lenB, L, R, mid, K) ->
    Mid = (L + R) div 2,
    Count = count_less_equal(A, B, Mid),
    if
        Count < K ->
            kthSmallestProduct(A, B, left, right, lenA, lenB, Mid + 1, R, (Mid + 1 + R) div 2, K);
        true ->
            kthSmallestProduct(A, B, left, right, lenA, lenB, L, Mid, (L + Mid) div 2, K)
    end.

count_less_equal(A, B, N) ->
    count_less_equal(A, B, N, 1, length(A), length(B), 0).

count_less_equal(_, _, _, _, _, _, Acc) when Acc >= 1000000000 ->
    1000000000;
count_less_equal(A, B, N, i, lenA, lenB, Acc) ->
    case i > lenA of
        true ->
            Acc;
        false ->
            Val = lists:nth(i, A),
            if
                Val == 0 ->
                    count_less_equal(A, B, N, i + 1, lenA, lenB, Acc + lenB);
                Val > 0 ->
                    j = find_j(B, N div Val, 1, lenB),
                    count_less_equal(A, B, N, i + 1, lenA, lenB, Acc + j);
                true ->
                    j = find_j(B, N div Val, 1, lenB),
                    count_less_equal(A, B, N, i + 1, lenA, lenB, Acc + (lenB - j + 1))
            end
    end.

find_j(_, _, J, _) when J > length(B) ->
    0;
find_j(B, Target, J, LenB) ->
    Val = lists:nth(J, B),
    if
        Val <= Target ->
            find_j(B, Target, J + 1, LenB);
        true ->
            J - 1
    end.