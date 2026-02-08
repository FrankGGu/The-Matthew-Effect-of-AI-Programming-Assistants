-module(solution).
-export([find_order/2]).

find_order(N, Prerequisites) ->
    Graph = build_graph(N, Prerequisites),
    case topological_sort(Graph, N) of
        {ok, Order} -> lists:reverse(Order);
        _ -> []
    end.

build_graph(N, Prerequisites) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({X, Y}, Acc) ->
        lists:replace(Acc, X, [Y | lists:nth(X + 1, Acc)])
    end, Graph, Prerequisites).

topological_sort(Graph, N) ->
    {Order, Visited} = topological_sort_helper(Graph, [], lists:duplicate(N, false)),
    if
        length(Order) == N -> {ok, Order};
        true -> error
    end.

topological_sort_helper([], Order, Visited) -> {Order, Visited};
topological_sort_helper([H | T], Order, Visited) ->
    case lists:nth(H + 1, Visited) of
        true -> topological_sort_helper(T, Order, Visited);
        false ->
            Visited1 = lists:replace(Visited, H, true),
            case topological_sort_helper(get_neighbors(H, Graph), Order, Visited1) of
                {NewOrder, NewVisited} ->
                    topological_sort_helper(T, [H | NewOrder], NewVisited)
            end
    end.

get_neighbors(Node, Graph) ->
    lists:nth(Node + 1, Graph).