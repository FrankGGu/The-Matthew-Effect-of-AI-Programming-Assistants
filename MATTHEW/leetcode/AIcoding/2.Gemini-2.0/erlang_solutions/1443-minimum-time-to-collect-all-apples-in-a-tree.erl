-module(minimum_time_collect_apples).
-export([min_time_collect_apples/2]).

min_time_collect_apples(N, Edges, HasApple) ->
    Graph = build_graph(Edges),
    dfs(0, -1, Graph, HasApple).

build_graph(Edges) ->
    build_graph(Edges, dict:new()).

build_graph([], Graph) ->
    Graph;
build_graph([[U, V] | Rest], Graph) ->
    Graph1 = add_edge(U, V, Graph),
    build_graph(Rest, Graph1).

add_edge(U, V, Graph) ->
    Graph1 = add_node(U, Graph),
    Graph2 = add_node(V, Graph1),
    Graph3 = dict:update(U, fun(Neighbors) -> [V | Neighbors] end, [V], Graph2),
    dict:update(V, fun(Neighbors) -> [U | Neighbors] end, [U], Graph3).

add_node(Node, Graph) ->
    case dict:is_key(Node, Graph) of
        true -> Graph;
        false -> dict:put(Node, [], Graph)
    end.

dfs(Node, Parent, Graph, HasApple) ->
    Neighbors = dict:fetch(Node, Graph),
    Time = lists:foldl(
        fun(Neighbor, Acc) ->
            case Neighbor =/= Parent of
                true ->
                    ChildTime = dfs(Neighbor, Node, Graph, HasApple);
                    case ChildTime > 0 of
                        true -> Acc + ChildTime + 2;
                        false -> Acc
                    end;
                false -> Acc
            end
        end,
        0,
        Neighbors
    ),
    case Time > 0; lists:nth(Node + 1, HasApple) of
        true -> Time;
        false -> 0
    end.