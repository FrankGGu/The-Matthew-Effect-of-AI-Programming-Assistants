-module(solution).
-export([max_star_sum/2]).

max_star_sum(Values, Edges) ->
    Graph = build_graph(Values, Edges),
    lists:foldl(fun({Node, _}, Acc) -> 
        MaxStarSum(Node, Graph, Values, Acc)
    end, 0, Graph).

build_graph(Values, Edges) ->
    Graph = lists:foldl(fun({A, B}, Acc) -> 
        maps:update(A, [B | maps:get(A, Acc, [])], Acc)
    end, maps:from_list(lists:map(fun(N) -> {N, []} end, lists:seq(0, length(Values) - 1)), []), Edges),
    Graph.

MaxStarSum(Node, Graph, Values, Acc) ->
    StarNodes = maps:get(Node, Graph, []),
    StarSum = lists:sum(lists:map(fun(N) -> lists:nth(N + 1, Values) end, lists:filter(fun(N) -> lists:nth(N + 1, Values) > 0 end, StarNodes))),
    max(Values(Node + 1), Acc + StarSum).

max(A, B) -> if A > B -> A; true -> B end.