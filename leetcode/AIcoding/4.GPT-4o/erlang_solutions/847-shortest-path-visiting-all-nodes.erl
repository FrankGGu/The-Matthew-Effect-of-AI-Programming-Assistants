-module(solution).
-export([shortestPathLength/1]).

shortestPathLength(Graph) ->
    N = length(Graph),
    VisitedStates = lists:seq(0, (1 bsl N) - 1),
    initial_states = [{0, 1} | lists:map(fun X -> {X, 1 bsl X} end, lists:seq(1, N - 1))],
    bfs(initial_states, VisitedStates, Graph, 0).

bfs([], _, _, Min) -> Min;
bfs([{Node, Visited} | Rest], VisitedStates, Graph, Min) ->
    if
        Visited band (1 bsl Node) == Visited ->
            bfs(Rest, VisitedStates, Graph, Min);
        Visited == (1 bsl length(Graph)) - 1 ->
            MinNew = min(Min, length(VisitedStates) - length(Rest)),
            bfs([], VisitedStates, Graph, MinNew);
        true ->
            NewStates = [ {Next, Visited bor (1 bsl Next)} || Next <- Graph[Node], not (Visited band (1 bsl Next)) ],
            bfs(Rest ++ NewStates, VisitedStates, Graph, Min)
    end.