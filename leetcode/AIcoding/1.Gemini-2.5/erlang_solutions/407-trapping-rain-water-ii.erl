-module(solution).
-export([trapRainWater/1]).

trapRainWater(HeightMap) ->
    M = length(HeightMap),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(HeightMap)),
            case N of
                0 -> 0;
                _ when M < 3 orelse N < 3 -> 0;
                _ ->
                    InitialMinHeap = erlang:min_heap:new(),
                    InitialVisited = gb_trees:new(),
                    {FinalMinHeap, FinalVisited} = populate_border(HeightMap, M, N, InitialMinHeap, InitialVisited),
                    calculate_water(HeightMap, M, N, FinalMinHeap, FinalVisited, 0)
            end
    end.

populate_border(HeightMap, M, N, MinHeap, Visited) ->
    % Add first and last rows
    {MinHeap1, Visited1} = add_row_to_heap(HeightMap, 0, 0, N - 1, MinHeap, Visited),
    {MinHeap2, Visited2} = add_row_to_heap(HeightMap, M - 1, 0, N - 1, MinHeap1, Visited1),
    % Add first and last columns (excluding corners already added by rows)
    populate_border_cols_loop(HeightMap, M, N, 1, M - 2, MinHeap2, Visited2).

populate_border_cols_loop(HeightMap, M, N, R, MaxR, MinHeap, Visited) when R =< MaxR ->
    {MinHeap1, Visited1} = add_cell_to_heap(HeightMap, R, 0, MinHeap, Visited),
    {MinHeap2, Visited2} = add_cell_to_heap(HeightMap, R, N - 1, MinHeap1, Visited1),
    populate_border_cols_loop(HeightMap, M, N, R + 1, MaxR, MinHeap2, Visited2);
populate_border_cols_loop(_HeightMap, _M, _N, _R, _MaxR, MinHeap, Visited) ->
    {MinHeap, Visited}.

add_row_to_heap(HeightMap, R, C, MaxC, MinHeap, Visited) when C =< MaxC ->
    {MinHeap1, Visited1} = add_cell_to_heap(HeightMap, R, C, MinHeap, Visited),
    add_row_to_heap(HeightMap, R, C + 1, MaxC, MinHeap1, Visited1);
add_row_to_heap(_HeightMap, _R, _C, _MaxC, MinHeap, Visited) ->
    {MinHeap, Visited}.

add_cell_to_heap(HeightMap, R, C, MinHeap, Visited) ->
    case gb_trees:is_defined({R, C}, Visited) of
        true -> {MinHeap, Visited};
        false ->
            Height = get_height(HeightMap, R, C),
            NewMinHeap = erlang:min_heap:insert({Height, R, C}, MinHeap),
            NewVisited = gb_trees:insert({R, C}, true, Visited),
            {NewMinHeap, NewVisited}
    end.

calculate_water(HeightMap, M, N, MinHeap, Visited, TotalWater) ->
    case erlang:min_heap:is_empty(MinHeap) of
        true -> TotalWater;
        false ->
            {{CurrentHeight, R, C}, MinHeap2} = erlang:min_heap:get_min(MinHeap),
            Neighbors = [{R - 1, C}, {R + 1, C}, {R, C - 1}, {R, C + 1}],
            {NewMinHeap, NewVisited, NewTotalWater} =
                lists:foldl(
                    fun({NR, NC}, {AccMinHeap, AccVisited, AccTotalWater}) ->
                        if
                            NR >= 0, NR < M, NC >= 0, NC < N, not gb_trees:is_defined({NR, NC}, AccVisited) ->
                                NeighborHeight = get_height(HeightMap, NR, NC),
                                TrappedWater = erlang:max(0, CurrentHeight - NeighborHeight),
                                EffectiveHeight = erlang:max(CurrentHeight, NeighborHeight),
                                HeapAfterInsert = erlang:min_heap:insert({EffectiveHeight, NR, NC}, AccMinHeap),
                                VisitedAfterInsert = gb_trees:insert({NR, NC}, true, AccVisited),
                                {HeapAfterInsert, VisitedAfterInsert, AccTotalWater + TrappedWater};
                            true ->
                                {AccMinHeap, AccVisited, AccTotalWater}
                        end
                    end,
                    {MinHeap2, Visited, TotalWater},
                    Neighbors
                ),
            calculate_water(HeightMap, M, N, NewMinHeap, NewVisited, NewTotalWater)
    end.

get_height(HeightMap, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, HeightMap)).