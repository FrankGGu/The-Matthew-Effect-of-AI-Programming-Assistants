-module(solution).
-export([min_time/2]).

min_time(N, Dependencies) ->
    Graph = build_graph(N, Dependencies),
    Time = lists:duplicate(N, 0),
    Visited = lists:duplicate(N, false),
    MaxTime = dfs(Graph, Time, Visited, 0, [], 0),
    MaxTime.

build_graph(N, Dependencies) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({X, Y}, Acc) ->
        lists:update_element(X + 1, [Y + 1 | lists:nth(X + 1, Acc)], Acc)
    end, Graph, Dependencies).

dfs(Graph, Time, Visited, Node, Path, CurrTime) ->
    case lists:nth(Node + 1, Visited) of
        true -> {CurrTime, Path};
        false ->
            Visited1 = lists:update_element(Node + 1, true, Visited),
            CurrTime1 = lists:nth(Node + 1, Time) + CurrTime,
            Path1 = [Node | Path],
            lists:foldl(fun(Next, Acc) -> 
                dfs(Graph, Time, Visited1, Next - 1, Acc, CurrTime1)
            end, {CurrTime1, Path1}, lists:nth(Node + 1, Graph))
    end.