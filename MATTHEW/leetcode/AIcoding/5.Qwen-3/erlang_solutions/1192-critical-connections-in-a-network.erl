-module(solution).
-export([critical_connections/1]).

critical_connections(Conn) ->
    Nodes = lists:usort(lists:flatten(Conn)),
    Graph = build_graph(Conn),
    N = length(Nodes),
    Time = 0,
    Visited = sets:new(),
    Low = dict:new(),
    Disc = dict:new(),
    Result = [],
    dfs(0, -1, Visited, Disc, Low, Result, Graph, Nodes, Time),
    Result.

build_graph(Conn) ->
    F = fun([A,B], Acc) -> 
            Acc#{A => [B | maps:get(A, Acc, [])], B => [A | maps:get(B, Acc, [])]} end,
    lists:foldl(F, #{}, Conn).

dfs(Node, Parent, Visited, Disc, Low, Result, Graph, Nodes, Time) ->
    Visited1 = sets:add_element(Node, Visited),
    Disc1 = dict:store(Node, Time, Disc),
    Low1 = dict:store(Node, Time, Low),
    Time1 = Time + 1,
    Neighbors = maps:get(Node, Graph, []),
    lists:foreach(fun(Neighbor) ->
        if
            Neighbor == Parent -> ok;
            sets:is_element(Neighbor, Visited) ->
                Low2 = dict:update(Neighbor, fun(V) -> min(V, dict:fetch(Node, Disc1)) end, Low1),
                Low1 = Low2;
            true ->
                {Visited2, Disc2, Low2, Result2} = dfs(Neighbor, Node, Visited1, Disc1, Low1, Result, Graph, Nodes, Time1),
                Low3 = dict:update(Node, fun(V) -> min(V, dict:fetch(Neighbor, Low2)) end, Low2),
                if
                    dict:fetch(Neighbor, Low2) > dict:fetch(Node, Disc2) ->
                        Result3 = [[Node, Neighbor] | Result2],
                        Result3;
                    true ->
                        Result2
                end
        end
    end, []),
    {Visited1, Disc1, Low1, Result}.