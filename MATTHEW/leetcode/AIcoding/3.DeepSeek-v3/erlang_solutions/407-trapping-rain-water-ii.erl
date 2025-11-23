-module(solution).
-export([trap_rain_water/1]).

trap_rain_water(HeightMap) ->
    case HeightMap of
        [] -> 0;
        _ ->
            M = length(HeightMap),
            N = length(hd(HeightMap)),
            Visited = array:new([{size, M}, {default, array:new([{size, N}, {default, false}])}]),
            PriorityQueue = setup_priority_queue(HeightMap, M, N, Visited),
            Max = 0,
            Ans = 0,
            bfs(PriorityQueue, HeightMap, M, N, Visited, Max, Ans)
    end.

setup_priority_queue(HeightMap, M, N, Visited) ->
    setup_priority_queue(HeightMap, M, N, Visited, 0, gb_sets:new()).

setup_priority_queue(HeightMap, M, N, Visited, I, Queue) when I < M ->
    Row = lists:nth(I + 1, HeightMap),
    NewQueue = setup_row(Row, I, 0, N, Visited, Queue),
    setup_priority_queue(HeightMap, M, N, Visited, I + 1, NewQueue);
setup_priority_queue(_, _, _, _, _, Queue) ->
    Queue.

setup_row(Row, I, J, N, Visited, Queue) when J < N ->
    case I =:= 0 orelse I =:= length(Row) - 1 orelse J =:= 0 orelse J =:= N - 1 of
        true ->
            Visited1 = mark_visited(Visited, I, J),
            NewQueue = gb_sets:add_element({lists:nth(J + 1, Row), I, J}, Queue),
            setup_row(Row, I, J + 1, N, Visited1, NewQueue);
        false ->
            setup_row(Row, I, J + 1, N, Visited, Queue)
    end;
setup_row(_, _, _, _, _, Queue) ->
    Queue.

mark_visited(Visited, I, J) ->
    RowVisited = array:get(I, Visited),
    NewRowVisited = array:set(J, true, RowVisited),
    array:set(I, NewRowVisited, Visited).

bfs(Queue, HeightMap, M, N, Visited, Max, Ans) ->
    case gb_sets:is_empty(Queue) of
        true -> Ans;
        false ->
            {{H, I, J}, NewQueue} = gb_sets:take_smallest(Queue),
            NewMax = max(Max, H),
            Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
            {FinalQueue, FinalVisited, FinalAns} = 
                lists:foldl(fun({DI, DJ}, {Q, V, A}) ->
                    NI = I + DI,
                    NJ = J + DJ,
                    if
                        NI >= 0, NI < M, NJ >= 0, NJ < N ->
                            RowVisited = array:get(NI, V),
                            case array:get(NJ, RowVisited) of
                                false ->
                                    NewRowVisited = array:set(NJ, true, RowVisited),
                                    NewV = array:set(NI, NewRowVisited, V),
                                    NH = lists:nth(NJ + 1, lists:nth(NI + 1, HeightMap)),
                                    NewA = if NH < NewMax -> A + (NewMax - NH); true -> A end,
                                    NewQ = gb_sets:add_element({NH, NI, NJ}, Q),
                                    {NewQ, NewV, NewA};
                                true ->
                                    {Q, V, A}
                            end;
                        true ->
                            {Q, V, A}
                    end
                end, {NewQueue, Visited, Ans}, Directions),
            bfs(FinalQueue, HeightMap, M, N, FinalVisited, NewMax, FinalAns)
    end.