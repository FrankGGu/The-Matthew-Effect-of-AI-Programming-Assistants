-module(solution).
-export([update_matrix/1]).

-define(INF, 1000000).

update_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    {InitialQueue, InitialDistArrays} = init_dist_arrays(Matrix, Rows, Cols),
    bfs(InitialQueue, InitialDistArrays, Rows, Cols).

init_dist_arrays(Matrix, Rows, Cols) ->
    Queue = queue:new(),
    DistArrays = array:new([{size, Rows}]),

    {FinalQueue, FinalDistArrays} = lists:foldl(
        fun(R, {AccQueue, AccDistArrays}) ->
            RowList = lists:nth(R + 1, Matrix),
            DistRowArray = array:new([{size, Cols}]),

            {UpdatedQueue, UpdatedDistRowArray} = lists:foldl(
                fun(C, {Q, DR}) ->
                    Val = lists:nth(C + 1, RowList),
                    if
                        Val == 0 ->
                            {queue:in({R, C}, Q), array:set(C, 0, DR)};
                        true ->
                            {Q, array:set(C, ?INF, DR)}
                    end
                end, {AccQueue, DistRowArray}, lists:seq(0, Cols - 1)
            ),
            {UpdatedQueue, array:set(R, UpdatedDistRowArray, AccDistArrays)}
        end, {Queue, DistArrays}, lists:seq(0, Rows - 1)
    ),
    {FinalQueue, FinalDistArrays}.

bfs(Queue, DistArrays, Rows, Cols) ->
    if
        queue:is_empty(Queue) ->
            lists:reverse(lists:foldl(
                fun(R, Acc) ->
                    RowArray = array:get(R, DistArrays),
                    [array:to_list(RowArray) | Acc]
                end, [], lists:seq(0, Rows - 1)
            ));
        true ->
            {value, {R, C}, NewQueue} = queue:out(Queue),

            CurrentRowArray = array:get(R, DistArrays),
            CurrentDist = array:get(C, CurrentRowArray),

            Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

            {UpdatedQueue, UpdatedDistArrays} = lists:foldl(
                fun({NR, NC}, {Q, DA}) ->
                    if
                        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                            NeighborRowArray = array:get(NR, DA),
                            NeighborDist = array:get(NC, NeighborRowArray),
                            if
                                NeighborDist > CurrentDist + 1 ->
                                    NewNeighborRowArray = array:set(NC, CurrentDist + 1, NeighborRowArray),
                                    NewDA = array:set(NR, NewNeighborRowArray, DA),
                                    {queue:in({NR, NC}, Q), NewDA};
                                true -> {Q, DA}
                            end;
                        true -> {Q, DA}
                    end
                end, {NewQueue, DistArrays}, Neighbors
            ),
            bfs(UpdatedQueue, UpdatedDistArrays, Rows, Cols)
    end.