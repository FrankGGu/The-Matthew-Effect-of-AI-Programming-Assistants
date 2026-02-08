-module(maximum_increasing_cells).
-export([solve/1]).

solve(Matrix) ->
    {Rows, Cols} = matrix_size(Matrix),
    RowMax = lists:seq(1, Rows, []),
    ColMax = lists:seq(1, Cols, []),
    Cache = dict:new(),
    SortedCells = sort_cells(Matrix),

    lists:foldl(fun({Value, Row, Col}, AccCache) ->
                    MaxRow = dict:get(Row, AccCache, 0),
                    MaxCol = dict:get({Rows + Col}, AccCache, 0),
                    NewValue = 1 + max(MaxRow, MaxCol),
                    dict:store(Row, max(NewValue, dict:get(Row, AccCache, 0)),
                               dict:store({Rows + Col}, max(NewValue, dict:get({Rows + Col}, AccCache, 0)), AccCache))
                end, Cache, SortedCells).

matrix_size(Matrix) ->
    Rows = length(Matrix),
    Cols = length(lists:nth(1, Matrix)),
    {Rows, Cols}.

sort_cells(Matrix) ->
    Rows = length(Matrix),
    lists:sort(fun({V1, _, _}, {V2, _, _}) -> V1 < V2 end,
               lists:flatten([[{lists:nth(Col, lists:nth(Row, Matrix)), Row, Col} || Col <- lists:seq(1, length(lists:nth(Row, Matrix)))] || Row <- lists:seq(1, Rows)])).

lists:seq(Start, End, Acc) when Start > End ->
    Acc;
lists:seq(Start, End, Acc) ->
    lists:seq(Start + 1, End, Acc ++ [Start]).

solve(Matrix) ->
    {Rows, Cols} = matrix_size(Matrix),
    RowMax = lists:seq(1, Rows, []),
    ColMax = lists:seq(1, Cols, []),
    Cache = dict:new(),
    SortedCells = sort_cells(Matrix),

    FinalCache = lists:foldl(fun({Value, Row, Col}, AccCache) ->
                    MaxRow = dict:get(Row, AccCache, 0),
                    MaxCol = dict:get({Rows + Col}, AccCache, 0),
                    NewValue = 1 + max(MaxRow, MaxCol),
                    dict:store(Row, max(NewValue, dict:get(Row, AccCache, 0)),
                               dict:store({Rows + Col}, max(NewValue, dict:get({Rows + Col}, AccCache, 0)), AccCache))
                end, Cache, SortedCells),

    lists:max(dict:values(FinalCache)).