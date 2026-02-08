-module(solution).
-export([getRow/1]).

getRow(0) -> [1];
getRow(RowIndex) when RowIndex > 0 ->
    PrevRow = getRow(RowIndex - 1),
    Sums = lists:zipwith(fun(A, B) -> A + B end, PrevRow, tl(PrevRow)),
    [1 | Sums ++ [1]].