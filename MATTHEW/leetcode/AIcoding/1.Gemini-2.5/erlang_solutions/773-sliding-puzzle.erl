-module(solution).
-export([sliding_puzzle/1]).

sliding_puzzle(Board) ->
    InitialBoardFlat = lists:flatten(Board),
    Target = [1,2,3,4,5,0],
    Q = queue:in({InitialBoardFlat, 0}, queue:new()),
    Visited = gb_sets:add(InitialBoardFlat, gb_sets:empty()),
    bfs(Q, Visited, Target).

bfs(Q, _, Target) when queue:is_empty(Q) ->
    -1;
bfs(Q, Visited, Target) ->
    {{value, {CurrentBoard, Steps}}, Q1} = queue:out(Q),
    if CurrentBoard == Target ->
        Steps;
    true ->
        ZeroPos = lists:index_of(0, CurrentBoard) - 1,
        Neighbors = get_neighbors(ZeroPos),
        {NewQ, NewVisited} = lists:foldl(
            fun(NeighborPos, {AccQ, AccVisited}) ->
                NextBoard = swap(CurrentBoard, ZeroPos, NeighborPos),
                if gb_sets:is_member(NextBoard, AccVisited) ->
                    {AccQ, AccVisited};
                true ->
                    {queue:in({NextBoard, Steps + 1}, AccQ), gb_sets:add(NextBoard, AccVisited)}
                end
            end,
            {Q1, Visited},
            Neighbors
        ),
        bfs(NewQ, NewVisited, Target)
    end.

get_neighbors(ZeroPos) ->
    case ZeroPos of
        0 -> [1, 3];
        1 -> [0, 2, 4];
        2 -> [1, 5];
        3 -> [0, 4];
        4 -> [1, 3, 5];
        5 -> [2, 4]
    end.

swap(List, I, J) ->
    Tuple = list_to_tuple(List),
    ValI = element(I + 1, Tuple),
    ValJ = element(J + 1, Tuple),
    Tuple1 = setelement(I + 1, ValJ, Tuple),
    Tuple2 = setelement(J + 1, ValI, Tuple1),
    tuple_to_list(Tuple2).