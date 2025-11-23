-module(solution).
-export([camping_trip/1]).

camping_trip(Paths) ->
    Map = maps:from_list(Paths),
    Start = find_start(Map),
    Route = [],
    get_route(Start, Map, Route).

find_start(Map) ->
    lists:keyfind(0, 2, maps:to_list(Map)).

get_route(Node, Map, Route) ->
    case maps:is_key(Node, Map) of
        true ->
            Next = maps:get(Node, Map),
            get_route(Next, Map, [Node | Route]);
        false ->
            lists:reverse([Node | Route])
    end.