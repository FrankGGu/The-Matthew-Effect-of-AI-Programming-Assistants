-module(safest_path).
-export([max_safeness_factor/1]).

-define(DIRS, [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]).

max_safeness_factor(Grid) ->
    N = length(Grid),

    ArrayGrid = list_to_array_grid(Grid, N),

    SafenessMap = calculate_safeness_map(ArrayGrid, N),

    Low = 0,
    High = 2 * (N - 1), 

    binary_search(Low, High, SafenessMap, N).

list_to_array_grid(Grid, N) ->
    Rows = lists:map(fun(RowList) -> array:from_list(RowList) end, Grid),
    array:from_list(Rows).

get_cell_array(ArrayGrid, R, C) ->
    RowArray = array:get(R, ArrayGrid),
    array:get(C, RowArray).

calculate_safeness_map(ArrayGrid, N) ->
    Queue = queue:new(),
    SafenessMap = gb_trees:empty(), 

    {FinalQueue, FinalSafenessMap} = lists:foldl(
        fun(R, {CurrentQueue, CurrentMap}) ->
            lists:foldl(fun(C, {InnerQueue, InnerMap}) ->
                if get_cell_array(ArrayGrid, R, C) == 1 -> 
                    {queue:in({R, C}, InnerQueue), gb_trees:enter({R, C}, 0, InnerMap)};
                true ->
                    {InnerQueue, gb_trees:enter({R, C}, -1, InnerMap)} 
                end
            end, {CurrentQueue, CurrentMap}, lists:seq(0, N-1))
        end, {Queue, SafenessMap}, lists:seq(0, N-1)
    ),

    bfs_safeness_map(FinalQueue, FinalSafenessMap, N).

bfs_safeness_map(Queue, SafenessMap, N) ->
    if queue:is_empty(Queue) ->
        SafenessMap;
    true ->
        {{value, {R, C}}, NewQueue} = queue:out(Queue),
        {value, CurrentSafenessVal} = gb_trees:lookup({R, C}, SafenessMap), 

        {NextQueue, NextSafenessMap} = lists:foldl(
            fun({DR, DC}, {AccQueue, AccMap}) ->
                NR = R + DR,
                NC = C + DC,

                if NR >= 0 andalso NR < N andalso NC >= 0 andalso NC < N ->
                    case gb_trees:lookup({NR, NC}, AccMap) of
                        {value, -1} -> 
                            NewSafeness = CurrentSafenessVal + 1, 
                            {queue:in({NR, NC}, AccQueue), gb_trees:enter({NR, NC}, NewSafeness, AccMap)};
                        _ -> 
                            {AccQueue, AccMap}
                    end;
                true ->
                    {AccQueue, AccMap}
                end
            end, {NewQueue, SafenessMap}, ?DIRS
        ),
        bfs_safeness_map(NextQueue, NextSafenessMap, N)
    end.

binary_search(Low, High, SafenessMap, N) ->
    if Low > High ->
        High; 
    true ->
        Mid = Low + (High - Low) div 2,
        if check_path_map(Mid, SafenessMap, N) ->
            binary_search(Mid + 1, High, SafenessMap, N); 
        true ->
            binary_search(Low, Mid - 1, SafenessMap, N)  
        end
    end.

check_path_map(Threshold, SafenessMap, N) ->
    {value, StartVal} = gb_trees:lookup({0,0}, SafenessMap), 
    {value, EndVal} = gb_trees:lookup({N-1,N-1}, SafenessMap), 

    if StartVal < Threshold or EndVal < Threshold ->
        false;
    true ->
        Queue = queue:new(),
        Queue1 = queue:in({0, 0}, Queue),
        Visited = gb_sets:empty(), 
        Visited1 = gb_sets:add({0, 0}, Visited),

        bfs_path_map(Queue1, Visited1, Threshold, SafenessMap, N)
    end.

bfs_path_map(Queue, Visited, Threshold, SafenessMap, N) ->
    if queue:is_empty(Queue) ->
        false; 
    true ->
        {{value, {R, C}}, NewQueue} = queue:out(Queue),

        if R == N - 1 andalso C == N - 1 ->
            true; 
        true ->
            {NextQueue, NextVisited} = lists:foldl(
                fun({DR, DC}, {AccQueue, AccVisited}) ->
                    NR = R + DR,
                    NC = C + DC,

                    if NR >= 0 andalso NR < N andalso NC >= 0 andalso NC < N ->
                        if not gb_sets:is_member({NR, NC}, AccVisited) ->
                            {value, NeighborSafeness} = gb_trees:lookup({NR, NC}, SafenessMap), 
                            if NeighborSafeness >= Threshold ->
                                {queue:in({NR, NC}, AccQueue), gb_sets:add({NR, NC}, AccVisited)};
                            true ->
                                {AccQueue, AccVisited}
                            end;
                        true ->
                            {AccQueue, AccVisited}
                        end;
                    true ->
                        {AccQueue, AccVisited}
                    end
                end, {NewQueue, Visited}, ?DIRS
            ),
            bfs_path_map(NextQueue, NextVisited, Threshold, SafenessMap, N)
        end
    end.