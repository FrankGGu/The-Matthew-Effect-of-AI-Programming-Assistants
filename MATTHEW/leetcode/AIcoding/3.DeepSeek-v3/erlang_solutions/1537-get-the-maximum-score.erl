-module(solution).
-export([max_sum/2]).

max_sum(Nums1, Nums2) ->
    {Sum1, Sum2, I, J} = {0, 0, 0, 0},
    {Sum1, Sum2, I, J} = max_sum(Nums1, Nums2, Sum1, Sum2, I, J),
    max(Sum1, Sum2) rem 1000000007.

max_sum([], [], Sum1, Sum2, _, _) -> {Sum1, Sum2, 0, 0};
max_sum([H1 | T1] = L1, [H2 | T2] = L2, Sum1, Sum2, I, J) when H1 < H2 ->
    max_sum(T1, L2, Sum1 + H1, Sum2, I + 1, J);
max_sum([H1 | T1] = L1, [H2 | T2] = L2, Sum1, Sum2, I, J) when H1 > H2 ->
    max_sum(L1, T2, Sum1, Sum2 + H2, I, J + 1);
max_sum([H | T1], [H | T2], Sum1, Sum2, I, J) ->
    NewSum = max(Sum1, Sum2) + H,
    {NewSum, NewSum, I + 1, J + 1} = max_sum(T1, T2, NewSum, NewSum, I + 1, J + 1);
max_sum([], L2, Sum1, Sum2, I, J) ->
    {Sum1, Sum2 + lists:sum(L2), I, J};
max_sum(L1, [], Sum1, Sum2, I, J) ->
    {Sum1 + lists:sum(L1), Sum2, I, J}.