-module(max_path_quality).
-export([maxPathQuality/2]).

maxPathQuality(Edges, MaxTime) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten(Edges)),
    Results = [],
    lists:foreach(fun(Node) -> dfs(Node, Node, 0, Graph, MaxTime, [Node], Results) end, Nodes),
    lists:max(Results).

build_graph(Edges) ->
    maps:from_list([ {A, lists:usort(maps:get(A, Graph, [])) ++ [B]} || {A, B} <- Edges ]).

dfs(Current, Start, Time, Graph, MaxTime, Visited, Results) ->
    case Time > MaxTime of
        true -> ok;
        false ->
            Value = get_value(Visited),
            Results = [Value | Results],
            lists:foreach(fun({Next, Cost}) ->
                case lists:member(Next, Visited) of
                    true -> dfs(Next, Start, Time + Cost, Graph, MaxTime, Visited, Results);
                    false -> dfs(Next, Start, Time + Cost, Graph, MaxTime, [Next | Visited], Results)
                end
            end, maps:get(Current, Graph, []))
    end.

get_value(Visited) ->
    lists:sum([1 || _ <- Visited]).