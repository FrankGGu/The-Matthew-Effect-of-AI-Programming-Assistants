-module(solution).
-export([maxDistance/1]).

-include_lib("stdlib/include/array.hrl").
-include_lib("stdlib/include/queue.hrl").

maxDistance(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    if Rows == 0 orelse Cols == 0 ->
        -1;
       true ->
            DistGrid = array:new(Rows * Cols, {default, -1}),
            Queue = queue:new(),
            InitialMaxDist = -1,

            {InitialQueue, InitialDistGrid} =
                lists:foldl(fun(R, {AccQ, AccDistGrid}) ->
                                lists:foldl(fun(C, {InnerAccQ, InnerAccDistGrid}) ->
                                                Val = get_cell_val(Grid, R, C),
                                                Idx = R * Cols + C,
                                                case Val of
                                                    1 ->
                                                        NewDistGrid = array:set(Idx, 0, InnerAccDistGrid),
                                                        NewQ = queue:in({R, C}, InnerAccQ),
                                                        {NewQ, NewDistGrid};
                                                    0 ->
                                                        {InnerAccQ, InnerAccDistGrid}
                                                end
                                        end, {AccQ, AccDistGrid}, lists:seq(0, Cols - 1))
                            end, {Queue, DistGrid}, lists:seq(0, Rows - 1)),

            case queue:is_empty(InitialQueue) of
                true ->
                    -1;
                false ->
                    bfs(InitialQueue, InitialDistGrid, Rows, Cols, InitialMaxDist)
            end
    end.

get_cell_val(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

bfs(Queue, DistGrid, Rows, Cols, CurrentMaxDist) ->
    case queue:out(Queue) of
        {{value, {R, C}}, QueueTail} ->
            Idx = R * Cols + C,
            CurrentCellDist = array:get(Idx, DistGrid),

            Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

            {NewQueue, NewDistGrid, NewMaxDist} =
                lists:foldl(fun({NR, NC}, {AccQ, AccDistGrid, AccMaxDist}) ->
                                if NR >= 0 andalso NR < Rows andalso
                                   NC >= 0 andalso NC < Cols ->
                                        NeighborIdx = NR * Cols + NC,
                                        NeighborDist = array:get(NeighborIdx, AccDistGrid),
                                        case NeighborDist of
                                            -1 ->
                                                NewNeighborDist = CurrentCellDist + 1,
                                                UpdatedDistGrid = array:set(NeighborIdx, NewNeighborDist, AccDistGrid),
                                                UpdatedMaxDist = max(AccMaxDist, NewNeighborDist),
                                                UpdatedQ = queue:in({NR, NC}, AccQ),
                                                {UpdatedQ, UpdatedDistGrid, UpdatedMaxDist};
                                            _ ->
                                                {AccQ, AccDistGrid, AccMaxDist}
                                        end;
                                   true ->
                                        {AccQ, AccDistGrid, AccMaxDist}
                                end
                            end, {QueueTail, DistGrid, CurrentMaxDist}, Neighbors),

            bfs(NewQueue, NewDistGrid, Rows, Cols, NewMaxDist);
        {empty, _} ->
            if CurrentMaxDist == -1 -> -1;
               true -> CurrentMaxDist
            end
    end.