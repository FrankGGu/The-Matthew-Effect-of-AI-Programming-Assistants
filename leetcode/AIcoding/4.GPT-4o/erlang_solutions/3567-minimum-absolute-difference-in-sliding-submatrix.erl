-module(solution).
-export([min_absolute_difference/3]).

min_absolute_difference(Matrix, K, X) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Submatrix = lists:sublist(Matrix, 1, K),
    MinAbsDiff = lists:foldl(fun(RowAcc, MinAcc) ->
        lists:foldl(fun(Element, Acc) ->
            AbsDiff = abs(Element - X),
            min(AbsDiff, Acc)
        end, MinAcc, RowAcc)
    end, infinity, Submatrix),
    MinAbsDiff.

min(A, B) when A < B -> A;
min(_, B) -> B.