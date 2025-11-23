-module(solution).
-export([matrixSum/1]).

matrixSum(Nums) ->
    SortedNums = [lists:sort(Row) || Row <- Nums],

    case SortedNums of
        [] -> 0;
        [H|_] when H == [] -> 0;
        _ ->
            K = length(hd(SortedNums)),
            sum_columns_max(SortedNums, K, 0)
    end.

sum_columns_max(_SortedNums, 0, Acc) ->
    Acc;
sum_columns_max(SortedNums, ColIndex, Acc) ->
    CurrentColumnElements = [lists:nth(ColIndex, Row) || Row <- SortedNums],
    MaxInCurrentColumn = lists:max(CurrentColumnElements),
    NewAcc = Acc + MaxInCurrentColumn,
    sum_columns_max(SortedNums, ColIndex - 1, NewAcc).