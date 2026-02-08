-module(solution).
-export([updateMatrix/1]).

-define(INF, 1000000). % A sufficiently large number for infinity

updateMatrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),

    % Initialize distances and queue
    {InitialDistancesTree, Queue} = initialize(Matrix, Rows, Cols),

    % Perform BFS
    FinalDistancesTree = bfs(Queue, InitialDistancesTree, Rows, Cols),

    % Convert gb_tree back to list of lists matrix
    gb_tree_to_list_of_lists(FinalDistancesTree, Rows, Cols).

initialize(Matrix, Rows, Cols) ->
    InitialDistancesTree = gb_trees:empty(),
    Queue = queue:new(),
    initialize_loop(0, 0, Matrix, InitialDistancesTree, Queue, Rows, Cols).

initialize_loop(R, C, Matrix, AccDistancesTree, AccQueue, Rows, Cols) when R < Rows ->
    Cell = lists:nth(C + 1, lists:nth(R + 1, Matrix)),

    NewAccDistancesTree = gb_trees:insert({R, C}, if Cell == 0 -> 0; true -> ?INF end, AccDistancesTree),
    NewAccQueue = if Cell == 0 -> queue:in({R, C}, AccQueue); true -> AccQueue end,

    NextC = C + 1,
    if
        NextC < Cols ->
            initialize_loop(R, NextC, Matrix, NewAccDistancesTree, NewAccQueue, Rows, Cols);
        true -> % C == Cols
            initialize_loop(R + 1, 0, Matrix, NewAccDistancesTree, NewAccQueue, Rows, Cols)
    end;
initialize_loop(_R, _C, _Matrix, AccDistancesTree, AccQueue, _Rows, _Cols) ->
    {AccDistancesTree, AccQueue}.

bfs(Queue, DistancesTree, Rows, Cols) ->
    bfs_loop(Queue, DistancesTree, Rows, Cols).

bfs_loop(Queue, DistancesTree, Rows, Cols) ->
    case queue:out(Queue) of
        {{value, {R, C}}, NewQueue} ->
            CurrentDist = gb_trees:get({R, C}, DistancesTree),
            Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

            {UpdatedDistancesTree, EnqueuedQueue} = lists:foldl(
                fun({NR, NC}, {AccDistances, AccQueue}) ->
                    if
                        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                            NeighborDist = gb_trees:get({NR, NC}, AccDistances),
                            if
                                CurrentDist + 1 < NeighborDist ->
                                    NewAccDistances = gb_trees:update({NR, NC}, CurrentDist + 1, AccDistances),
                                    NewAccQueue = queue:in({NR, NC}, AccQueue),
                                    {NewAccDistances, NewAccQueue};
                                true ->
                                    {AccDistances, AccQueue}
                            end;
                        true ->
                            {AccDistances, AccQueue}
                    end
                end,
                {DistancesTree, NewQueue},
                Neighbors
            ),
            bfs_loop(EnqueuedQueue, UpdatedDistancesTree, Rows, Cols);
        {empty, _} ->
            DistancesTree
    end.

gb_tree_to_list_of_lists(Tree, Rows, Cols) ->
    lists:map(
        fun(R) ->
            lists:map(
                fun(C) ->
                    gb_trees:get({R, C}, Tree)
                end,
                lists:seq(0, Cols - 1)
            )
        end,
        lists:seq(0, Rows - 1)
    ).