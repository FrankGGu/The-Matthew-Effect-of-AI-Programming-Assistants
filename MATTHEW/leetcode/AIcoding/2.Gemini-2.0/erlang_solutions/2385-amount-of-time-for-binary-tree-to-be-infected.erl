-module(infection_time).
-export([amount_of_time/1]).

-record(node, {val, left, right}).

amount_of_time(Root) ->
    {Graph, Start} = build_graph(Root, -1),
    bfs(Graph, Start).

build_graph(Root, StartVal) ->
    build_graph(Root, StartVal, [], []).

build_graph(null, StartVal, Graph, Start) ->
    {lists:reverse(Graph), Start};
build_graph({Val, Left, Right}, StartVal, Graph, Start) ->
    NewStart = if Val == StartVal then Val else Start,
    {NewGraph1, NewStart1} = build_graph(Left, StartVal, Graph, NewStart),
    {NewGraph2, NewStart2} = build_graph(Right, StartVal, NewGraph1, NewStart1),
    NewGraph = 
        case Left of
            null ->
                case Right of
                    null ->
                        NewGraph2;
                    _ ->
                        [{Val, [ValLeft || ValLeft <- [element(1, Right)]]} | NewGraph2]
                end;
            _ ->
                case Right of
                    null ->
                        [{Val, [ValLeft || ValLeft <- [element(1, Left)]]} | NewGraph2];
                    _ ->
                        [{Val, [ValLeft || ValLeft <- [element(1, Left), element(1, Right))]]} | NewGraph2]
                end
        end,
    {NewGraph, NewStart2}.

bfs(Graph, Start) ->
    bfs(Graph, [Start], #{Start => 0}, 0).

bfs(_Graph, [], _Visited, MaxTime) ->
    MaxTime;
bfs(Graph, Queue, Visited, MaxTime) ->
    {Node, RestQueue} = lists:split(1, Queue),
    {H, T} = {lists:nth(1, Node), RestQueue},
    Neighbors = get_neighbors(Graph, H),
    NewNeighbors = [N || N <- Neighbors, not maps:is_key(N, Visited)],
    NewQueue = T ++ NewNeighbors,
    NewVisited = lists:foldl(fun(N, Acc) ->
        maps:put(N, maps:get(H, Visited) + 1, Acc)
    end, Visited, NewNeighbors),
    NewMaxTime = max(MaxTime, lists:foldl(fun(N, Acc) ->
        max(Acc, maps:get(N, NewVisited))
    end, 0, NewNeighbors)),
    bfs(Graph, NewQueue, NewVisited, NewMaxTime).

get_neighbors(Graph, Node) ->
    case lists:keyfind(Node, 1, Graph) of
        false -> [];
        {_, Neighbors} -> Neighbors
    end.