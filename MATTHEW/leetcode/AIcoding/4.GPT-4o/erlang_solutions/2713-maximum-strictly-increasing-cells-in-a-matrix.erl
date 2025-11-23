-module(solution).
-export([max_increasing_cells/1]).

max_increasing_cells(Matrix) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    CellValues = lists:flat(Matrix),
    SortedCells = lists:sort(fun({V1, _}, {V2, _}) -> V1 < V2 end, lists:map(fun(X, Y) -> {X, Y} end, CellValues, lists:seq(1, length(CellValues)))),
    {MaxCount, _} = lists:foldl(fun({Value, Index}, {Count, Visited}) ->
        Row = (Index - 1) div M,
        Col = (Index - 1) rem M,
        NewCount = case lists:member({Row, Col}, Visited) of
            true -> Count;
            false -> Count + 1
        end,
        {NewCount, Visited ++ [{Row, Col}]}
    end, {0, []}, SortedCells),
    MaxCount.