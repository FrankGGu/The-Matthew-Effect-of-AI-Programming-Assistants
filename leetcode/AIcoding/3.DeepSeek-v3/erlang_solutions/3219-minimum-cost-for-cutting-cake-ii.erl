-module(solution).
-export([min_cost/2]).

min_cost(Cake, CutCost) ->
    Rows = length(Cake),
    Cols = length(hd(Cake)),
    RowCuts = 0,
    ColCuts = 0,
    {RowPieces, ColPieces} = {1, 1},
    Heap = create_heap(Cake, Rows, Cols),
    min_cost(Heap, RowPieces, ColPieces, RowCuts, ColCuts, CutCost).

create_heap(Cake, Rows, Cols) ->
    Heap = gb_trees:empty(),
    create_row_edges(Heap, Cake, Rows, Cols, 0),
    create_col_edges(Heap, Cake, Rows, Cols, 0).

create_row_edges(Heap, Cake, Rows, Cols, I) when I < Rows - 1 ->
    Edge = 0,
    NewHeap = gb_trees:enter({row, I}, Edge, Heap),
    create_row_edges(NewHeap, Cake, Rows, Cols, I + 1);
create_row_edges(Heap, _, _, _, _) -> Heap.

create_col_edges(Heap, Cake, Rows, Cols, J) when J < Cols - 1 ->
    Edge = 0,
    NewHeap = gb_trees:enter({col, J}, Edge, Heap),
    create_col_edges(NewHeap, Cake, Rows, Cols, J + 1);
create_col_edges(Heap, _, _, _, _) -> Heap.

min_cost(Heap, RowPieces, ColPieces, RowCuts, ColCuts, CutCost) ->
    case gb_trees:is_empty(Heap) of
        true -> 0;
        false ->
            {{Key, Edge}, NewHeap} = gb_trees:take_largest(Heap),
            case Key of
                {row, _} ->
                    Cost = Edge * ColPieces * CutCost,
                    Cost + min_cost(NewHeap, RowPieces + 1, ColPieces, RowCuts + 1, ColCuts, CutCost);
                {col, _} ->
                    Cost = Edge * RowPieces * CutCost,
                    Cost + min_cost(NewHeap, RowPieces, ColPieces + 1, RowCuts, ColCuts + 1, CutCost)
            end
    end.