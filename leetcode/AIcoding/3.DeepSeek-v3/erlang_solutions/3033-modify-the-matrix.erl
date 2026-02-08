-module(solution).
-export([modified_matrix/1]).

modified_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxCols = lists:foldl(fun(Row, Acc) ->
                            lists:zipwith(fun(X, Y) -> max(X, Y) end, Row, Acc)
                         end, lists:duplicate(Cols, -1), Matrix),
    lists:map(fun(Row) ->
                lists:map(fun
                    (-1) -> lists:nth(index_of(-1, Row) + 1, MaxCols);
                    (X) -> X
                end, Row)
              end, Matrix).

index_of(Item, List) -> index_of(Item, List, 1).
index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|Tl], Index) -> index_of(Item, Tl, Index + 1);
index_of(_, [], _) -> -1.