-module(solution).
-export([diagonalSort/1]).

diagonalSort(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Diagonals = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Key = I - J,
            Val = lists:nth(I+1, Matrix),
            Val2 = lists:nth(J+1, Val),
            maps:update_with(Key, fun(V) -> [Val2 | V] end, [Val2], Acc2)
        end, Acc, lists:seq(0, Cols-1))
    end, #{}, lists:seq(0, Rows-1)),

    SortedDiagonals = maps:map(fun(_, D) -> lists:sort(D) end, Diagonals),

    Result = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Key = I - J,
            [H | T] = maps:get(Key, SortedDiagonals),
            Row = lists:nth(I+1, Acc2),
            NewRow = lists:sublist(Row, J) ++ [H] ++ lists:tl(lists:sublist(Row, J+1, length(Row))),
            lists:sublist(Acc2, I) ++ [NewRow] ++ lists:tl(lists:sublist(Acc2, I+1, length(Acc2)))
        end, Acc, lists:seq(0, Cols-1))
    end, Matrix, lists:seq(0, Rows-1)),

    Result.