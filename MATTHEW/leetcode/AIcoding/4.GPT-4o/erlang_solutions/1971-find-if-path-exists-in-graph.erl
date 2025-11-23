-module(solution).
-export([valid_path/3]).

valid_path(N, Edges, Start, End) ->
    Graph = build_graph(N, Edges),
    bfs(Start, End, Graph, []).

build_graph(N, Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(1, N))), Edges).

bfs(Start, End, Graph, Visited) ->
    case Start =:= End of
        true -> true;
        false ->
            case lists:member(Start, Visited) of
                true -> false;
                false ->
                    NextNodes = maps:get(Start, Graph, []),
                    lists:any(fun(Node) -> bfs(Node, End, Graph, [Start | Visited]) end, NextNodes)
            end
    end.