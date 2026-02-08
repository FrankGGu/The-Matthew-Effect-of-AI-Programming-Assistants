-module(solution).
-export([check_if_prerequisite/4]).

check_if_prerequisite(N, Prerequisites, Queries) ->
    Graph = build_graph(N, Prerequisites),
    Results = lists:map(fun(Query) -> is_reachable(Graph, Query) end, Queries),
    Results.

build_graph(N, Prerequisites) ->
    Graph = lists:foldl(fun({X, Y}, Acc) ->
        maps:update_with(X, fun(L) -> [Y | L] end, fun() -> [Y] end, Acc)
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(0, N-1))), Prerequisites),
    Graph.

is_reachable(Graph, {X, Y}) ->
    case maps:get(X, Graph) of
        [] -> false;
        Neighbors -> dfs(Neighbors, Y, maps:remove(X, Graph), [])
    end.

dfs([], _, _, _) -> false;
dfs([H | T], Y, Graph, Visited) ->
    if
        H == Y -> true;
        lists:member(H, Visited) -> dfs(T, Y, Graph, Visited);
        true -> dfs(T, Y, maps:get(H, Graph), [H | Visited])
    end.