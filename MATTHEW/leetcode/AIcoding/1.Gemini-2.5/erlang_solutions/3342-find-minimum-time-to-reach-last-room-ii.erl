-module(solution).
-export([min_time_to_reach_last_room/2]).

-define(DIRS, [{0,1}, {0,-1}, {1,0}, {-1,0}]).
-define(INF, 1_000_000_000). %% A sufficiently large number for infinity

min_time_to_reach_last_room(RoomsList, Sources) ->
    N = length(RoomsList),
    M = length(hd(RoomsList)),

    %% Convert RoomsList (list of lists) to a map for efficient access
    RoomsMap = build_rooms_map(RoomsList),

    %% Step 1: Calculate water arrival times for all rooms using multi-source BFS
    WaterTime = bfs_water_times(RoomsMap, Sources, N, M),

    %% Step 2: Dijkstra to find minimum path time
    dijkstra_path(RoomsMap, WaterTime, N, M).

build_rooms_map(RoomsList) ->
    build_rooms_map_rows(0, RoomsList, maps:new()).

build_rooms_map_rows(R, [Row | RestRows], AccMap) ->
    NewAccMap = build_rooms_map_cols(R, 0, Row, AccMap),
    build_rooms_map_rows(R + 1, RestRows, NewAccMap);
build_rooms_map_rows(_R, [], AccMap) ->
    AccMap.

build_rooms_map_cols(R, C, [Cell | RestCells], AccMap) ->
    NewAccMap = maps:put({R, C}, Cell, AccMap),
    build_rooms_map_cols(R, C + 1, RestCells, NewAccMap);
build_rooms_map_cols(_R, _C, [], AccMap) ->
    AccMap.

bfs_water_times(RoomsMap, Sources, N, M) ->
    InitialWaterTime = maps:new(),
    Q = queue:new(),

    {WaterTime1, Q1} = lists:foldl(
        fun({R, C}, {AccWaterTime, AccQ}) ->
            case maps:get({R, C}, RoomsMap, 1) of %% Default 1 if not in map (locked)
                0 -> %% It's an empty room
                    case maps:find({R, C}, AccWaterTime) of
                        {ok, 0} -> {AccWaterTime, AccQ}; %% Already processed as source
                        _ ->
                            NewWaterTime = maps:put({R, C}, 0, AccWaterTime),
                            NewQ = queue:in({R, C}, AccQ),
                            {NewWaterTime, NewQ}
                    end;
                1 -> %% It's a locked room, ignore
                    {AccWaterTime, AccQ}
            end
        end,
        {InitialWaterTime, Q},
        Sources
    ),

    bfs_water_loop(WaterTime1, Q1, RoomsMap, N, M).

bfs_water_loop(WaterTime, Q, RoomsMap, N, M) ->
    case queue:out(Q) of
        {{value, {R, C}}, NewQ} ->
            CurrentTime = maps:get({R, C}, WaterTime, ?INF),
            {NextWaterTime, NextQ} = lists:foldl(
                fun({DR, DC}, {AccWaterTime, AccQ}) ->
                    NR = R + DR,
                    NC = C + DC,
                    if
                        NR >= 0, NR < N, NC >= 0, NC < M ->
                            case maps:get({NR, NC}, RoomsMap, 1) of
                                0 -> %% It's an empty room
                                    NeighborWaterTime = maps:get({NR, NC}, AccWaterTime, ?INF),
                                    if
                                        CurrentTime + 1 < NeighborWaterTime ->
                                            NewAccWaterTime = maps:put({NR, NC}, CurrentTime + 1, AccWaterTime),
                                            NewAccQ = queue:in({NR, NC}, AccQ),
                                            {NewAccWaterTime, NewAccQ};
                                        true ->
                                            {AccWaterTime, AccQ}
                                    end;
                                1 -> %% Locked room
                                    {AccWaterTime, AccQ}
                            end;
                        true -> %% Out of bounds
                            {AccWaterTime, AccQ}
                    end
                end,
                {WaterTime, NewQ},
                ?DIRS
            ),
            bfs_water_loop(NextWaterTime, NextQ, RoomsMap, N, M);
        {empty, _} ->
            WaterTime
    end.

dijkstra_path(RoomsMap, WaterTime, N, M) ->
    %% Check initial room (0,0) condition
    case maps:get({0, 0}, RoomsMap, 1) of
        1 -> -1; %% (0,0) is locked
        0 ->
            StartWaterTime = maps:get({0, 0}, WaterTime, ?INF),
            if
                StartWaterTime == 0 ->
                    -1; %% Cannot start at (0,0) if water arrives at time 0
                true ->
                    Dist = maps:new(),
                    PQ = gb_trees:empty(),

                    InitialDist = maps:put({0, 0}, 0, Dist),
                    InitialPQ = gb_trees:insert(0, {0, 0}, PQ), %% {Time, {R,C}}

                    dijkstra_loop(InitialDist, InitialPQ, WaterTime, RoomsMap, N, M)
            end
    end.

dijkstra_loop(Dist, PQ, WaterTime, RoomsMap, N, M) ->
    case gb_trees:is_empty(PQ) of
        true ->
            -1; %% Target not reached
        false ->
            {{Time, {R, C}}, NewPQ} = gb_trees:take_min(PQ),

            CurrentDist = maps:get({R, C}, Dist, ?INF),
            if
                Time > CurrentDist -> %% Already found a shorter path
                    dijkstra_loop(Dist, NewPQ, WaterTime, RoomsMap, N, M);
                true ->
                    if
                        R == N - 1 and C == M - 1 ->
                            Time; %% Reached target
                        true ->
                            {NextDist, NextPQ} = lists:foldl(
                                fun({DR, DC}, {AccDist, AccPQ}) ->
                                    NR = R + DR,
                                    NC = C + DC,
                                    if
                                        NR >= 0, NR < N, NC >= 0, NC < M ->
                                            case maps:get({NR, NC}, RoomsMap, 1) of
                                                0 -> %% It's an empty room
                                                    NewTime = Time + 1,
                                                    NeighborWaterTime = maps:get({NR, NC}, WaterTime, ?INF),
                                                    NeighborCurrentDist = maps:get({NR, NC}, AccDist, ?INF),
                                                    if
                                                        NewTime < NeighborWaterTime and NewTime < NeighborCurrentDist ->
                                                            NewAccDist = maps:put({NR, NC}, NewTime, AccDist),
                                                            NewAccPQ = gb_trees:insert(NewTime, {NR, NC}, AccPQ),
                                                            {NewAccDist, NewAccPQ};
                                                        true ->
                                                            {AccDist, AccPQ}
                                                    end;
                                                1 -> %% Locked room
                                                    {AccDist, AccPQ}
                                            end;
                                        true -> %% Out of bounds
                                            {AccDist, AccPQ}
                                    end
                                end,
                                {Dist, NewPQ},
                                ?DIRS
                            ),
                            dijkstra_loop(NextDist, NextPQ, WaterTime, RoomsMap, N, M)
                    end
            end
    end.