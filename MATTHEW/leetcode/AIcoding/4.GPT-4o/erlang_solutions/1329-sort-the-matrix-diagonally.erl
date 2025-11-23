-module(solution).
-export([diagonalSort/1]).

diagonalSort(Matrix) ->
    SortedMatrix = lists:map(fun(Row) -> lists:map(fun({Val, _}) -> Val end, Row) end,
        lists:map(fun({RowIdx, ColIdx}) ->
            Row = lists:map(fun({RowIdx2, ColIdx2}) ->
                case lists:nth(RowIdx2 + 1, Matrix) of
                    [] -> {0, 0}; 
                    L -> if ColIdx2 + 1 =< length(L) -> {lists:nth(ColIdx2 + 1, L), RowIdx2} 
                        end 
                end
            end, lists:seq(0, length(Matrix) - 1)),
            lists:sort(fun({A, _}, {B, _}) -> A < B end, Row)
        end, lists:seq(0, length(Matrix) - 1)),
    lists:zip(SortedMatrix, lists:seq(0, length(Matrix) - 1)),
    lists:map(fun({SortedRow, RowIdx}) ->
        lists:map(fun({Val, ColIdx}) -> 
            case lists:nth(ColIdx + 1, SortedRow) of 
                {V, _} -> V 
            end 
        end, lists:zip(SortedRow, lists:seq(0, length(SortedRow) - 1))) 
    end, SortedMatrix).