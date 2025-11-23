-module(solution).
-export([maximum_profit/2]).

maximum_profit(Profit, Edges) ->
    N = length(Profit),
    Graph = build_graph(Edges, N),
    InDegrees = lists:duplicate(N, 0),
    InDegrees1 = lists:foldl(fun({U, V}, Acc) -> lists:update_element(V + 1, lists:element(U + 1, Acc) + 1, Acc) end, InDegrees, Edges),
    TopoSort = topological_sort(Graph, InDegrees1),
    calculate_profit(Profit, TopoSort).

build_graph(Edges, N) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({U, V}, Acc) -> lists:update_element(U + 1, [V | lists:element(U + 1, Acc)], Acc) end, Graph, Edges).

topological_sort(Graph, InDegrees) ->
    Que = lists:filter(fun(X) -> lists:element(X + 1, InDegrees) == 0 end, lists:seq(0, length(Graph) - 1)),
    topo_sort_helper(Graph, InDegrees, Que, []).

topo_sort_helper(_, [], Acc, Acc) -> lists:reverse(Acc);
topo_sort_helper(Graph, InDegrees, [H | T], Acc) ->
    NewAcc = [H | Acc],
    NewInDegrees = lists:foldl(fun(V, Acc1) -> lists:update_element(V + 1, lists:element(V + 1, Acc1) - 1, Acc1) end, InDegrees, lists:element(H + 1, Graph)),
    NewQue = lists:filter(fun(X) -> lists:element(X + 1, NewInDegrees) == 0 end, lists:seq(0, length(Graph) - 1)),
    topo_sort_helper(Graph, NewInDegrees, T ++ NewQue, NewAcc).

calculate_profit(Profit, TopoSort) ->
    ProfitTable = lists:duplicate(length(Profit), 0),
    lists:foldl(fun(Node, Acc) -> 
        CurrentProfit = lists:element(Node + 1, Acc) + lists:element(Node + 1, Profit),
        lists:update_element(Node + 1, CurrentProfit, Acc) 
    end, ProfitTable, TopoSort).