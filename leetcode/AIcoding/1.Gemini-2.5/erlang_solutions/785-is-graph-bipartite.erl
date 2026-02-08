-module(solution).
-export([is_bipartite/1]).

is_bipartite(GraphList) ->
    N = length(GraphList),

    GraphArray = array:from_list(GraphList),

    InitialColorsArray = array:new([{size, N}, {fixed, true}, {default, 0}]),

    check_all_nodes(0, N, GraphArray, InitialColorsArray).

check_all_nodes(N, N, _GraphArray, _ColorsArray) ->
    true;
check_all_nodes(CurrentNode, N, GraphArray, ColorsArray) ->
    case array:get(CurrentNode, ColorsArray) of
        0 ->
            UpdatedColorsArray = array:set(CurrentNode, 1, ColorsArray),
            InitialQueue = queue:in(CurrentNode, queue:new()),

            case bfs(GraphArray, UpdatedColorsArray, InitialQueue) of
                {ok, NewColorsArray} ->
                    check_all_nodes(CurrentNode + 1, N, GraphArray, NewColorsArray);
                {error, not_bipartite} ->
                    false
            end;
        _ ->
            check_all_nodes(CurrentNode + 1, N, GraphArray, ColorsArray)
    end.

bfs(_GraphArray, ColorsArray, Queue) when queue:is_empty(Queue) ->
    {ok, ColorsArray};
bfs(GraphArray, ColorsArray, Queue) ->
    {{value, U}, RestQueue} = queue:out(Queue),
    U_color = array:get(U, ColorsArray),
    OppositeColor = case U_color of 1 -> 2; 2 -> 1 end,
    Neighbors = array:get(U, GraphArray),

    {Result, NewColorsArray, NewQueue} = process_neighbors(Neighbors, U_color, OppositeColor, GraphArray, ColorsArray, RestQueue),

    case Result of
        {error, not_bipartite} ->
            {error, not_bipartite};
        ok ->
            bfs(GraphArray, NewColorsArray, NewQueue)
    end.

process_neighbors([], _U_color, _OppositeColor, _GraphArray, ColorsArray, Queue) ->
    {ok, ColorsArray, Queue};
process_neighbors([V|RestNeighbors], U_color, OppositeColor, GraphArray, ColorsArray, Queue) ->
    V_color = array:get(V, ColorsArray),
    case V_color of
        0 ->
            UpdatedColorsArray = array:set(V, OppositeColor, ColorsArray),
            UpdatedQueue = queue:in(V, Queue),
            process_neighbors(RestNeighbors, U_color, OppositeColor, GraphArray, UpdatedColorsArray, UpdatedQueue);
        U_color ->
            {error, not_bipartite, Queue};
        _ ->
            process_neighbors(RestNeighbors, U_color, OppositeColor, GraphArray, ColorsArray, Queue)
    end.