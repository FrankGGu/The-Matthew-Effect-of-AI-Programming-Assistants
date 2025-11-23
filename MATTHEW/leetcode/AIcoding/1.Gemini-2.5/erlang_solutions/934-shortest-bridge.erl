-module(shortest_bridge).
-export([shortest_bridge/1]).

shortest_bridge(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),

    {_Found, VisitedDFS, FirstIslandCells} = find_first_island(Grid, N, M),

    BFSQueue = lists:foldl(fun(Cell, Q) -> queue:in(Cell, Q) end, queue:new(), FirstIslandCells),
    BFSVisited = VisitedDFS,

    bfs_loop(BFSQueue, BFSVisited, Grid, N, M, 0).

find_first_island(Grid, N, M) ->
    lists:foldl(fun(R, {Found, Visited, Island}) ->
                    if Found -> {Found, Visited, Island};
                       true ->
                         lists:foldl(fun(C, {InnerFound, InnerVisited, InnerIsland}) ->
                                         if InnerFound -> {InnerFound, InnerVisited, InnerIsland};
                                            true ->
                                              Val = element(R+1, element(C+1, Grid)),
                                              if Val == 1 andalso not gb_sets:is_member({R, C}, InnerVisited) ->
                                                 {FinalVisited, FinalIsland} = dfs_collect(R, C, Grid, N, M, InnerVisited, []),
                                                 {true, FinalVisited, FinalIsland};
                                                 true -> {false, InnerVisited, InnerIsland}
                                              end
                                         end
                                      end, {false, Visited, Island}, lists:seq(0, M-1))
                    end
                 end, {false, gb_sets:new(), []}, lists:seq(0, N-1)).

dfs_collect(R, C, Grid, N, M, Visited, AccIsland) ->
    if R < 0; R >= N; C < 0; C >= M -> {Visited, AccIsland};
       gb_sets:is_member({R, C}, Visited) -> {Visited, AccIsland};
       element(R+1, element(C+1, Grid)) == 0 -> {Visited, AccIsland};
       true ->
         NewVisited = gb_sets:add({R, C}, Visited),
         NewAccIsland = [{R, C} | AccIsland],
         {V1, I1} = dfs_collect(R+1, C, Grid, N, M, NewVisited, NewAccIsland),
         {V2, I2} = dfs_collect(R-1, C, Grid, N, M, V1, I1),
         {V3, I3} = dfs_collect(R, C+1, Grid, N, M, V2, I2),
         dfs_collect(R, C-1, Grid, N, M, V3, I3)
    end.

bfs_loop(Queue, VisitedBFS, Grid, N, M, Distance) ->
    {Found, NextQueue, FinalVisitedBFS} = process_level(Queue, VisitedBFS, Grid, N, M, queue:new(), VisitedBFS),
    if Found -> Distance;
       queue:is_empty(NextQueue) -> -1;
       true -> bfs_loop(NextQueue, FinalVisitedBFS, Grid, N, M, Distance + 1)
    end.

process_level(CurrentQueue, VisitedBFS, Grid, N, M, NextQueueAcc, AccVisitedBFS) ->
    if queue:is_empty(CurrentQueue) -> {false, NextQueueAcc, AccVisitedBFS};
       true ->
         {{value, {R, C}}, QRest} = queue:out(CurrentQueue),
         Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],
         {FoundInNeighbors, NewNextQueueAcc, NewAccVisitedBFS} =
           lists:foldl(fun({NR, NC}, {Found, NQ, AV}) ->
                           if Found -> {true, NQ, AV};
                              NR < 0; NR >= N; NC < 0; NC >= M -> {Found, NQ, AV};
                              gb_sets:is_member({NR, NC}, AV) -> {Found, NQ, AV};
                              true ->
                                Val = element(NR+1, element(NC+1, Grid)),
                                if Val == 1 -> {true, NQ, AV};
                                   true -> {Found, queue:in({NR, NC}, NQ), gb_sets:add({NR, NC}, AV)}
                                end
                           end
                        end, {false, NextQueueAcc, AccVisitedBFS}, Neighbors),
         if FoundInNeighbors -> {true, NextQueueAcc, AccVisitedBFS};
            true -> process_level(QRest, VisitedBFS, Grid, N, M, NewNextQueueAcc, NewAccVisitedBFS)
         end
    end.