-module(row_with_max_ones).
-export([maxOneRow/1]).

maxOneRow(Matrix) ->
    maxOneRow(Matrix, 0, -1, 0).

maxOneRow([], Index, MaxIndex, MaxCount) ->
    MaxIndex;
maxOneRow([Row | Rest], Index, MaxIndex, MaxCount) ->
    Count = countOnes(Row),
    if
        Count > MaxCount ->
            maxOneRow(Rest, Index + 1, Index, Count);
        true ->
            maxOneRow(Rest, Index + 1, MaxIndex, MaxCount)
    end.

countOnes(List) ->
    countOnes(List, 0).

countOnes([], Count) ->
    Count;
countOnes([1 | Rest], Count) ->
    countOnes(Rest, Count + 1);
countOnes([_ | Rest], Count) ->
    countOnes(Rest, Count).