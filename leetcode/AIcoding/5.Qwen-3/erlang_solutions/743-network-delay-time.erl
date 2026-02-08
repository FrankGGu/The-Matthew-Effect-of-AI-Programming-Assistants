-module(solution).
-export([network_delay_time/2]).

network_delay_time(Edges, N) ->
    Graph = build_graph(Edges),
    Dijkstra:run(Graph, 1, N).

build_graph(Edges) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        Maps = maps:get(U, Acc, #{}),
        NewMaps = maps:put(V, W, Maps),
        maps:put(U, NewMaps, Acc)
    end, #{}, Edges).

-module(dijkstra).
-export([run/3]).

run(Graph, Start, N) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
    Dist1 = maps:put(Start, 0, Dist),
    Queue = priority_queue:init([{0, Start}]),
    dijkstra(Graph, Dist1, Queue).

dijkstra(_Graph, Dist, []) ->
    Max = lists:max(maps:values(Dist)),
    if
        Max == infinity -> -1;
        true -> Max
    end;

dijkstra(Graph, Dist, Queue) ->
    {MinDist, Node} = priority_queue:pop(Queue),
    case maps:get(Node, Dist) of
        MinDist ->
            Neighbors = maps:get(Node, Graph, #{}),
            lists:foreach(fun({Neighbor, Weight}) ->
                NewDist = MinDist + Weight,
                case maps:get(Neighbor, Dist) of
                    OldDist when NewDist < OldDist ->
                        Dist1 = maps:put(Neighbor, NewDist, Dist),
                        Queue1 = priority_queue:push({NewDist, Neighbor}, Queue),
                        dijkstra(Graph, Dist1, Queue1);
                    _ ->
                        ok
                end
            end, maps:to_list(Neighbors)),
            dijkstra(Graph, Dist, Queue);
        _ ->
            dijkstra(Graph, Dist, Queue)
    end.

-module(priority_queue).
-export([init/1, push/2, pop/1]).

init(List) ->
    lists:sort(List).

push(Item, List) ->
    lists:usort([Item | List]).

pop([H | T]) ->
    {H, T}.