-module(solution).
-export([min_jumps/1]).

min_jumps(Arr) ->
    N = length(Arr),
    if N == 1 -> 0;
       true ->
            ValueMap = build_value_map(Arr, 0, #{}),
            Visited = sets:from_list([0]),
            Queue = queue:in({0, 0}, queue:new()),
            bfs(Queue, Visited, ValueMap, Arr, N)
    end.

build_value_map([], _, Map) -> Map;
build_value_map([Val | Rest], Index, Map) ->
    case maps:find(Val, Map) of
        {ok, Indices} -> NewMap = maps:put(Val, [Index | Indices], Map);
        error -> NewMap = maps:put(Val, [Index], Map)
    end,
    build_value_map(Rest, Index + 1, NewMap).

bfs(Queue, Visited, ValueMap, Arr, N) ->
    {{value, {Pos, Steps}}, Q} = queue:out(Queue),
    NextPositions = get_next_positions(Pos, Arr, ValueMap, Visited, N),
    case lists:member(N - 1, NextPositions) of
        true -> Steps + 1;
        false ->
            NewVisited = lists:foldl(fun(P, V) -> sets:add_element(P, V) end, Visited, NextPositions),
            NewQueue = lists:foldl(fun(P, Q) -> queue:in({P, Steps + 1}, Q) end, Q, NextPositions),
            bfs(NewQueue, NewVisited, ValueMap, Arr, N)
    end.

get_next_positions(Pos, Arr, ValueMap, Visited, N) ->
    Val = lists:nth(Pos + 1, Arr),
    SameValueIndices = case maps:find(Val, ValueMap) of
                           {ok, Indices} -> Indices;
                           error -> []
                       end,
    Adjacent = [Pos - 1, Pos + 1],
    AllPositions = SameValueIndices ++ Adjacent,
    lists:filter(fun(P) -> P >= 0 andalso P < N andalso not sets:is_element(P, Visited) end, AllPositions).