-module(solution).
-export([amountOfTime/2]).

-record(tree_node, {val, left, right}).

amountOfTime(Root, Start) ->
    AdjMap = build_graph(Root, #{}),

    Queue0 = queue:in({Start, 0}, queue:new()),
    Visited0 = maps:put(Start, true, #{}),

    bfs(Queue0, Visited0, 0, AdjMap).

build_graph(nil, AdjMap) -> AdjMap;
build_graph(#tree_node{val=Val, left=Left, right=Right}, AdjMap) ->
    AdjMapWithLeft = case Left of
        nil -> AdjMap;
        #tree_node{val=LVal} ->
            maps:update_with(Val, fun(L) -> [LVal | L] end, [],
            maps:update_with(LVal, fun(L) -> [Val | L] end, [], AdjMap))
    end,

    AdjMapWithRight = case Right of
        nil -> AdjMapWithLeft;
        #tree_node{val=RVal} ->
            maps:update_with(Val, fun(L) -> [RVal | L] end, [],
            maps:update_with(RVal, fun(L) -> [Val | L] end, [], AdjMapWithLeft))
    end,

    build_graph(Left, build_graph(Right, AdjMapWithRight)).

bfs(Queue, Visited, MaxTime, AdjMap) ->
    case queue:out(Queue) of
        {{value, {CurrentNodeVal, CurrentTime}}, RestQueue} ->
            NewMaxTime = max(MaxTime, CurrentTime),
            Neighbors = maps:get(CurrentNodeVal, AdjMap, []),

            {NewQueue, NewVisited} = lists:foldl(
                fun(Neighbor, {QAcc, VAcc}) ->
                    case maps:is_key(Neighbor, VAcc) of
                        true -> {QAcc, VAcc};
                        false -> {queue:in({Neighbor, CurrentTime + 1}, QAcc), maps:put(Neighbor, true, VAcc)}
                    end
                end, {RestQueue, Visited}, Neighbors),

            bfs(NewQueue, NewVisited, NewMaxTime, AdjMap);
        {empty, _} ->
            MaxTime
    end.