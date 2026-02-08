-module(solution).
-export([maximum_network_quality/2]).

maximum_network_quality(Coordinates, Connections) ->
    {ok, N} = lists:foldl(fun({X, Y}, Acc) -> max(Acc, max(X, Y)) end, {ok, 0}, Coordinates),
    Graph = create_graph(Connections),
    lists:foldl(fun(Coord, Acc) -> calculate_quality(Coord, Graph, N, Acc) end, {0, 0}, Coordinates).

create_graph(Connections) ->
    lists:foldl(fun({A, B}, Acc) -> 
        case maps:is_key(A, Acc) of
            true -> maps:update(A, fun(X) -> [B | X] end, Acc);
            false -> maps:put(A, [B], Acc)
        end
    end, #{}, Connections).

calculate_quality({X, Y, Q}, Graph, N, {MaxQuality, MaxCoord}) ->
    Neighbors = maps:get(X, Graph, []),
    TotalQuality = Q + lists:sum(lists:map(fun(N) -> maps:get(N, Coordinates, 0) end, Neighbors)),
    if
        TotalQuality > MaxQuality -> {TotalQuality, X};
        TotalQuality == MaxQuality -> {MaxQuality, min(X, MaxCoord)};
        true -> {MaxQuality, MaxCoord}
    end.