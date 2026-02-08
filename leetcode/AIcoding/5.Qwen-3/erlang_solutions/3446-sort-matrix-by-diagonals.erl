-module(solution).
-export([diagonalSort/1]).

diagonalSort(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Diagonals = lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Acc2) -> 
            Key = I - J,
            Value = lists:nth(I+1, Matrix),
            Value2 = lists:nth(J+1, Value),
            maps:update_with(Key, fun(V) -> [Value2 | V] end, [Value2], Acc2)
        end, Acc, lists:seq(0, Cols-1))
    end, #{}, lists:seq(0, Rows-1)),

    SortedDiagonals = maps:map(fun(_, D) -> lists:sort(D) end, Diagonals),

    Result = lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Acc2) -> 
            Key = I - J,
            [Val | Rest] = maps:get(Key, SortedDiagonals),
            Row = lists:nth(I+1, Acc2),
            NewRow = lists:sublist(Row, J) ++ [Val] ++ lists:nthtail(J+1, Row),
            lists:substitute(I+1, NewRow, Acc2)
        end, Acc, lists:seq(0, Cols-1))
    end, Matrix, lists:seq(0, Rows-1)),

    Result.