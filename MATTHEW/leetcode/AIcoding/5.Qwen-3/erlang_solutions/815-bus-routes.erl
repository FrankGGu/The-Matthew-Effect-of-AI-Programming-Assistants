-module(bus_routes).
-export([num_buses_to_destination/2]).

num_buses_to_destination(Routes, Target) ->
    Routes1 = lists:map(fun lists:sort/1, Routes),
    RouteMap = build_route_map(Routes1),
    visited = sets:new(),
    queue = queue:from_list([{0, 0}]),
    num_buses_to_destination(RouteMap, Target, visited, queue).

build_route_map(Routes) ->
    Map = dict:new(),
    build_route_map(Routes, 0, Map).

build_route_map([], _, Map) ->
    Map;
build_route_map([Route | Rest], Index, Map) ->
    NewMap = lists:foldl(fun(Stop, Acc) ->
        dict:update_counter(Stop, Index, Acc)
    end, Map, Route),
    build_route_map(Rest, Index + 1, NewMap).

num_buses_to_destination(_RouteMap, Target, _Visited, Queue) when queue:is_empty(Queue) ->
    -1;
num_buses_to_destination(RouteMap, Target, Visited, Queue) ->
    {{Value, Buses}, NewQueue} = queue:out(Queue),
    case Value of
        Target ->
            Buses;
        _ ->
            case sets:is_element(Value, Visited) of
                true ->
                    num_buses_to_destination(RouteMap, Target, Visited, NewQueue);
                false ->
                    NewVisited = sets:add_element(Value, Visited),
                    Routes = dict:fetch(Value, RouteMap),
                    NewQueue1 = lists:foldl(fun(RouteIndex, Q) ->
                        lists:foldl(fun(Stop, Q1) ->
                            if Stop == Value -> Q1;
                               true -> queue:in({Stop, Buses + 1}, Q1)
                            end
                        end, Q, dict:fetch(RouteIndex, RouteMap))
                    end, NewQueue, Routes),
                    num_buses_to_destination(RouteMap, Target, NewVisited, NewQueue1)
            end
    end.