-module(maximum_star_sum).
-export([maxStarSum/2]).

maxStarSum(Edges, Values) ->
    NodeValues = maps:from_list([{N, V} || {N, V} <- Values]),
    Graph = buildGraph(Edges),
    MaxSum = 0,
    lists:foldl(fun(Node, Acc) ->
                        Sum = getTopTwoNeighbors(Node, Graph, NodeValues),
                        if
                            Sum > Acc -> Sum;
                            true -> Acc
                        end
                end, MaxSum, maps:keys(NodeValues)).

buildGraph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
                        Acc#{U => [V | maps:get(U, Acc, [])],
                             V => [U | maps:get(V, Acc, [])]}
                end, #{}, Edges).

getTopTwoNeighbors(Node, Graph, NodeValues) ->
    Neighbors = maps:get(Node, Graph, []),
    Sorted = lists:sort(fun(A, B) -> maps:get(A, NodeValues) > maps:get(B, NodeValues) end, Neighbors),
    TopTwo = lists:sublist(Sorted, 2),
    lists:sum([maps:get(N, NodeValues) || N <- TopTwo]) + maps:get(Node, NodeValues).