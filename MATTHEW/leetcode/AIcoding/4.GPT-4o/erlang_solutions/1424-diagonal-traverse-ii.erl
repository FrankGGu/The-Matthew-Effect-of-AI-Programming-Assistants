-module(solution).
-export([findDiagonalOrder/1]).

findDiagonalOrder(Matrix) ->
    DiagonalOrder = diagonal_traverse(Matrix, length(Matrix), length(hd(Matrix))),
    lists:flatten(DiagonalOrder).

diagonal_traverse([], _, _) -> [];
diagonal_traverse(Matrix, Rows, Cols) ->
    DiagonalList = lists:map(fun(Idx) -> get_diagonal(Matrix, Idx, Rows, Cols) end, lists:seq(0, Rows + Cols - 2)),
    lists:map(fun(List) -> lists:reverse(List) end, DiagonalList).

get_diagonal(_, -1, _, _) -> [];
get_diagonal(Matrix, Idx, Rows, Cols) ->
    lists:map(fun(I) -> 
        case I < Rows andalso (Idx - I) < Cols of
            true -> lists:nth(I + 1, Matrix) -- lists:nth(Idx - I + 1, lists:nth(I + 1, Matrix));
            false -> []
        end
    end, lists:seq(0, min(Idx, Rows - 1))).