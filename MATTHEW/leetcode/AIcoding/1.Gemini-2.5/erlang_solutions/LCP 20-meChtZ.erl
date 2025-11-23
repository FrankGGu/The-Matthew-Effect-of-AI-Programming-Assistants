-module(solution).
-export([num_buses_to_destination/3]).

num_buses_to_destination(Routes, Source, Target) ->
    if
        Source == Target -> 0;
        true ->
            StopToRoutesMap = build_stop_to_routes_map(Routes),
            Queue = queue:new(),
            VisitedRoutes = sets:new(),
            InitialRoutes = maps:get(Source, StopToRoutesMap, []),
            if
                InitialRoutes == [] -> -1;
                true ->
                    {Queue1, VisitedRoutes1} = lists:foldl(
                        fun(RouteIndex, {QAcc, VAAcc}) ->
                            QAcc1 = queue:in({RouteIndex, 1}, QAcc),
                            VAAcc1 = sets:add_element(RouteIndex, VAAcc),
                            {QAcc1, VAAcc1}
                        end,
                        {Queue, VisitedRoutes},
                        InitialRoutes
                    ),
                    bfs(Queue1, VisitedRoutes1, Routes, StopToRoutesMap, Target)
            end
    end.

build_stop_to_routes_map(Routes) ->
    build_stop_to_routes_map(Routes, 0, #{}).

build_stop_to_routes_map([], _Index, MapAcc) ->
    MapAcc;
build_stop_to_routes_map([Route | RestRoutes], Index, MapAcc) ->
    NewMapAcc = lists:foldl(
        fun(Stop, MapAcc2) ->
            maps:update_with(Stop, fun(Val) -> [Index | Val] end, [Index], MapAcc2)
        end,
        MapAcc,
        Route
    ),
    build_stop_to_routes_map(RestRoutes, Index + 1, NewMapAcc).

bfs(Queue, VisitedRoutes, Routes, StopToRoutesMap, Target) ->
    if
        queue:is_empty(Queue) ->
            -1;
        true ->
            {{CurrentRouteIndex, BusesTaken}, Queue1} = queue:out(Queue),
            CurrentRouteStops = lists:nth(CurrentRouteIndex + 1, Routes),
            if lists:member(Target, CurrentRouteStops) ->
                BusesTaken;
            true ->
                {Queue2, VisitedRoutes2} = lists:foldl(
                    fun(Stop, {QAcc, VAAcc}) ->
                        ConnectingRoutes = maps:get(Stop, StopToRoutesMap, []),
                        lists:foldl(
                            fun(NextRouteIndex, {QAcc2, VAAcc2}) ->
                                if sets:is_element(NextRouteIndex, VAAcc2) ->
                                    {QAcc2, VAAcc2};
                                true ->
                                    QAcc3 = queue:in({NextRouteIndex, BusesTaken + 1}, QAcc2),
                                    VAAcc3 = sets:add_element(NextRouteIndex, VAAcc2),
                                    {QAcc3, VAAcc3}
                                end
                            end,
                            {QAcc, VAAcc},
                            ConnectingRoutes
                        )
                    end,
                    {Queue1, VisitedRoutes},
                    CurrentRouteStops
                ),
                bfs(Queue2, VisitedRoutes2, Routes, StopToRoutesMap, Target)
            end
    end.