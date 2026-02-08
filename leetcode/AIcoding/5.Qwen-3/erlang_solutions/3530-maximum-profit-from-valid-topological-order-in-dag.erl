-module(solution).
-export([max_profit/2]).

max_profit(Edges, Prices) ->
    N = length(Edges),
    Graph = build_graph(Edges),
    InDegree = build_indegree(Edges),
    {TopoOrder, _} = topological_sort(Graph, InDegree),
    calculate_profit(TopoOrder, Prices).

build_graph(Edges) ->
    lists:foldl(fun({From, To}, Acc) ->
        case maps:is_key(From, Acc) of
            true -> maps:update(From, [To | maps:get(From, Acc)], Acc);
            false -> maps:put(From, [To], Acc)
        end
    end, #{}, Edges).

build_indegree(Edges) ->
    lists:foldl(fun({From, To}, Acc) ->
        case maps:is_key(To, Acc) of
            true -> maps:update(To, maps:get(To, Acc) + 1, Acc);
            false -> maps:put(To, 1, Acc)
        end
    end, #{}, Edges).

topological_sort(Graph, InDegree) ->
    Queue = lists:filter(fun(Node) -> maps:get(Node, InDegree, 0) == 0 end, maps:keys(InDegree)),
    TopoOrder = [],
    sort_helper(Queue, Graph, InDegree, TopoOrder).

sort_helper([], _, _, TopoOrder) ->
    {TopoOrder, ok};
sort_helper([Node | Rest], Graph, InDegree, TopoOrder) ->
    NewTopoOrder = [Node | TopoOrder],
    case maps:is_key(Node, Graph) of
        true ->
            lists:foreach(fun(Next) ->
                NewCount = maps:get(Next, InDegree) - 1,
                InDegree1 = maps:put(Next, NewCount, InDegree),
                if
                    NewCount == 0 -> sort_helper([Next | Rest], Graph, InDegree1, NewTopoOrder);
                    true -> sort_helper(Rest, Graph, InDegree1, NewTopoOrder)
                end
            end, maps:get(Node, Graph));
        false -> ok
    end,
    sort_helper(Rest, Graph, InDegree, NewTopoOrder).

calculate_profit([], _) -> 0;
calculate_profit([Node | Rest], Prices) ->
    Price = lists:nth(Node + 1, Prices),
    Price + calculate_profit(Rest, Prices).