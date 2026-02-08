-module(solution).
-export([fairPairs/3]).

fairPairs(Nums, Lower, Upper) when Lower > Upper ->
    0;
fairPairs(Nums, Lower, Upper) ->
    SortedNums = lists:sort(Nums),
    count_lte(Upper, SortedNums) - count_lte(Lower - 1, SortedNums).

count_lte(Target, SortedNums) ->
    N = length(SortedNums),
    Arr = array:from_list(SortedNums),
    count_lte_loop(Target, Arr, 0, N - 1, 0).

count_lte_loop(Target, Arr, Left, Right, Acc) when Left < Right ->
    ValLeft = array:get(Left, Arr),
    ValRight = array:get(Right, Arr),
    If
        ValLeft + ValRight =< Target ->
            count_lte_loop(Target, Arr, Left + 1, Right, Acc + (Right - Left));
        true ->
            count_lte_loop(Target, Arr, Left, Right - 1, Acc)
    End;
count_lte_loop(_Target, _Arr, _Left, _Right, Acc) ->
    Acc.