-module(solution).
-export([count_visits/1]).

count_visits(Graph) ->
    Visited = sets:new(),
    Results = lists:foldl(fun(Node, Acc) -> 
        case sets:is_element(Node, Visited) of
            true -> Acc;
            false -> 
                {Visited2, Count} = dfs(Node, Graph, sets:add(Node, Visited), 0),
                {Count, Acc}
        end
    end, [], lists:seq(1, length(Graph))),
    lists:reverse(Results).

dfs(Node, Graph, Visited, Count) ->
    Neighbors = lists:nth(Node, Graph),
    lists:foldl(fun(Neighbor, {VisitedAcc, CountAcc}) ->
        case sets:is_element(Neighbor, VisitedAcc) of
            true -> {VisitedAcc, CountAcc};
            false ->
                {VisitedNew, CountNew} = dfs(Neighbor, Graph, sets:add(Neighbor, VisitedAcc), CountAcc + 1),
                {VisitedNew, CountNew}
        end
    end, {Visited, Count + 1}, Neighbors).