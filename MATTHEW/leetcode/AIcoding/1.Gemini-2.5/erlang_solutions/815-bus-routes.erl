-module(bus_routes).
-export([num_buses_to_destination/3]).

num_buses_to_destination(Routes, Source, Target) ->
    if Source == Target -> 0;
       true ->
           RouteMap = build_route_map_sets(Routes, 0, #{}),
           StopToRoutes = build_stop_to_routes_map(Routes, 0, #{}),

           case maps:find(Source, StopToRoutes) of
               error -> -1;
               {ok, InitialRoutes} ->
                   Q0 = queue:new(),
                   VisitedRoutes0 = sets:new(),

                   {Result, Q1, VisitedRoutes1} = lists:foldl(
                       fun(RouteIdx, {AccResult, AccQ, AccVisited}) ->
                           if AccResult =/= undefined -> {AccResult, AccQ, AccVisited};
                              true ->
                                  case sets:is_element(RouteIdx, AccVisited) of
                                      true -> {AccResult, AccQ, AccVisited};
                                      false ->
                                          RouteStopsSet = maps:get(RouteIdx, RouteMap),
                                          if sets:is_element(Target, RouteStopsSet) ->
                                              {1, AccQ, AccVisited};
                                          true ->
                                              {undefined, queue:in({RouteIdx, 1}, AccQ), sets:add_element(RouteIdx, AccVisited)}
                                          end
                                  end
                           end
                       end, {undefined, Q0, VisitedRoutes0}, InitialRoutes),

                   if Result =/= undefined -> Result;
                      true ->
                           bfs(Q1, VisitedRoutes1, RouteMap, StopToRoutes, Target)
                   end
           end
    end.

build_route_map_sets([], _Idx, AccMap) -> AccMap;
build_route_map_sets([Route | RestRoutes], Idx, AccMap) ->
    NewAccMap = maps:put(Idx, sets:from_list(Route), AccMap),
    build_route_map_sets(RestRoutes, Idx + 1, NewAccMap).

build_stop_to_routes_map([], _Idx, AccMap) -> AccMap;
build_stop_to_routes_map([Route | RestRoutes], Idx, AccMap) ->
    NewAccMap = lists:foldl(
        fun(Stop, InnerAccMap) ->
            maps:update_with(Stop, fun(Val) -> [Idx | Val] end, [Idx], InnerAccMap)
        end, AccMap, Route),
    build_stop_to_routes_map(RestRoutes, Idx + 1, NewAccMap).

bfs(Queue, VisitedRoutes, RouteMap, StopToRoutes, Target) ->
    case queue:out(Queue) of
        {{value, {CurrentRouteIdx, BusesTaken}}, RestQueue} ->
            CurrentRouteStopsSet = maps:get(CurrentRouteIdx, RouteMap),

            {NextResult, NextQueue, NextVisitedRoutes} = lists:foldl(
                fun(Stop, {AccResult, AccQ, AccVisited}) ->
                    if AccResult =/= undefined -> {AccResult, AccQ, AccVisited};
                       true ->
                           case maps:find(Stop, StopToRoutes) of
                               error -> {AccResult, AccQ, AccVisited}; 
                               {ok, ConnectedRoutes} ->
                                   lists:foldl(
                                       fun(NextRouteIdx, {InnerAccResult, InnerAccQ, InnerAccVisited}) ->
                                           if InnerAccResult =/= undefined -> {InnerAccResult, InnerAccQ, InnerAccVisited};
                                              true ->
                                                  case sets:is_element(NextRouteIdx, InnerAccVisited) of
                                                      true -> {InnerAccResult, InnerAccQ, InnerAccVisited};
                                                      false ->
                                                          NextRouteStopsSet = maps:get(NextRouteIdx, RouteMap),
                                                          if sets:is_element(Target, NextRouteStopsSet) ->
                                                              {BusesTaken + 1, InnerAccQ, InnerAccVisited};
                                                          true ->
                                                              {undefined, queue:in({NextRouteIdx, BusesTaken + 1}, InnerAccQ), sets:add_element(NextRouteIdx, InnerAccVisited)}
                                                          end
                                                  end
                                           end
                                       end, {AccResult, AccQ, AccVisited}, ConnectedRoutes)
                           end
                    end
                end, {undefined, RestQueue, VisitedRoutes}, sets:to_list(CurrentRouteStopsSet)),

            if NextResult =/= undefined -> NextResult;
               true ->
                   bfs(NextQueue, NextVisitedRoutes, RouteMap, StopToRoutes, Target)
            end;
        {empty, _} ->
            -1
    end.