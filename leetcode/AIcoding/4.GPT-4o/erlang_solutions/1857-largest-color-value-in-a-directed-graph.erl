-module(solution).
-export([largest_color_value/2]).

largest_color_value(N, Edges) ->
    Colors = lists:map(fun({Color, _}) -> Color end, Edges),
    Graph = build_graph(N, Edges),
    ColorsCount = maps:from_list(lists:zip(Colors, lists:map(fun(_) -> 0 end, Colors))),
    case dfs(Graph, ColorsCount, N) of
        {error, _} -> -1;
        {ok, Result} -> lists:max(Result)
    end.

build_graph(N, Edges) ->
    lists:foldl(fun({From, To}, Acc) ->
        case maps:find(From, Acc) of
            {ok, Neighbors} -> maps:update(From, [To | Neighbors], Acc);
            _ -> maps:put(From, [To], Acc)
        end
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(0, N - 1))), Edges).

dfs(Graph, ColorsCount, N) ->
    Visited = maps:from_list(lists:map(fun(X) -> {X, false} end, lists:seq(0, N - 1))),
    lists:foldl(fun(Node, Acc) -> 
        case dfs_visit(Graph, Node, ColorsCount, Visited, Acc) of
            {error, _} -> {error, Node};
            Result -> Result
        end
    end, {ok, []}, lists:seq(0, N - 1)).

dfs_visit(Graph, Node, ColorsCount, Visited, Acc) ->
    case maps:find(Node, Visited) of
        {ok, true} -> {ok, Acc};
        _ ->
            Visited1 = maps:update(Node, true, Visited),
            case maps:find(Node, Graph) of
                {ok, Neighbors} ->
                    NewAcc = lists:foldl(fun(Neighbor, Acc1) ->
                        case dfs_visit(Graph, Neighbor, ColorsCount, Visited1, Acc1) of
                            {error, _} -> {error, Neighbor};
                            {ok, Res} -> Res
                        end
                    end, Acc, Neighbors),
                    {ok, [colors_count(Node, ColorsCount) | NewAcc]};
                _ -> {ok, [colors_count(Node, ColorsCount) | Acc]}
            end
    end.

colors_count(Node, ColorsCount) ->
    case maps:find(Node, ColorsCount) of
        {ok, Count} -> Count;
        _ -> 0
    end.