-module(maximum_score_after_applying_operations_on_a_tree).
-export([maximum_score_after_applying_operations_on_a_tree/2]).

maximum_score_after_applying_operations_on_a_tree(Edges, Values) ->
    N = length(Values),
    Graph = build_graph(Edges, N),
    {MaxScore, _} = dfs(0, -1, Values, Graph),
    MaxScore.

build_graph(Edges, N) ->
    build_graph(Edges, N, lists:seq(0, N - 1), []).

build_graph([], _, Nodes, Acc) ->
    lists:zip(Nodes, Acc);
build_graph([[U, V] | Rest], N, Nodes, Acc) ->
    NewAcc = lists:map(fun(Node, Neighbors) ->
                                 case (Node =:= U) of
                                     true -> [V | Neighbors];
                                     false -> case (Node =:= V) of
                                                  true -> [U | Neighbors];
                                                  false -> Neighbors
                                              end
                                 end
                         end, Nodes, Acc),
    build_graph(Rest, N, Nodes, NewAcc).

dfs(Node, Parent, Values, Graph) ->
    Neighbors = lists:keyfind(Node, 1, Graph),
    FilteredNeighbors = [Neighbor || Neighbor <- lists:nth(2, Neighbors), Neighbor /= Parent],
    case FilteredNeighbors of
        [] ->
            {lists:nth(Node + 1, Values), 0};
        _ ->
            Results = [dfs(Neighbor, Node, Values, Graph) || Neighbor <- FilteredNeighbors],
            SumOfZeros = lists:sum([Zero || {_Max, Zero} <- Results]),
            MinOfOnes = lists:min([_Max || {_Max, _Zero} <- Results]),
            Score1 = lists:nth(Node + 1, Values) + SumOfZeros,
            Score2 = lists:nth(Node + 1, Values) - MinOfOnes,
            {Score1, Score2}
    end.