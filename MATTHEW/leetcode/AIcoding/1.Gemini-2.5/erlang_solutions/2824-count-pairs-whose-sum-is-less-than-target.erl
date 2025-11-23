-module(solution).
-export([countPairs/2]).

countPairs(Nums, Target) ->
    SortedNumsList = lists:sort(Nums),
    N = length(SortedNumsList),
    SortedNumsArray = array:from_list(SortedNumsList),

    count_pairs_recursive(SortedNumsArray, Target, 0, N - 1, 0).

count_pairs_recursive(_SortedNumsArray, _Target, Left, Right, Acc) when Left >= Right ->
    Acc;
count_pairs_recursive(SortedNumsArray, Target, Left, Right, Acc) ->
    NumL = array:get(Left, SortedNumsArray),
    NumR = array:get(Right, SortedNumsArray),

    if
        NumL + NumR < Target ->
            NewAcc = Acc + (Right - Left),
            count_pairs_recursive(SortedNumsArray, Target, Left + 1, Right, NewAcc);
        true ->
            count_pairs_recursive(SortedNumsArray, Target, Left, Right - 1, Acc)
    end.