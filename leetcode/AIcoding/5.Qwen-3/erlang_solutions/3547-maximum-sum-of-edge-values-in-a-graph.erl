-module(maximum_sum_of_edge_values_in_a_graph).
-export([max_edge_sum/1]).

max_edge_sum(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    NodeCount = length(Nodes),
    Adj = maps:new(),
    lists:foreach(fun([U, V, W]) -> 
        Adj1 = maps:update(U, [V | maps:get(U, Adj, [])], Adj),
        Adj2 = maps:update(V, [U | maps:get(V, Adj, [])], Adj1),
        Adj2
    end, Edges),
    MaxSum = 0,
    lists:foldl(fun(Node, Acc) ->
        lists:foldl(fun(OtherNode, Acc2) ->
            case lists:member(OtherNode, Nodes) of
                true ->
                    EdgeWeight = get_edge_weight(Edges, Node, OtherNode),
                    if EdgeWeight > Acc2 -> EdgeWeight; true -> Acc2 end;
                false -> Acc2
            end
        end, Acc, Nodes)
    end, MaxSum, Nodes).

get_edge_weight([], _, _) -> 0;
get_edge_weight([[U, V, W] | _], U, V) -> W;
get_edge_weight([[U, V, W] | T], U, V) -> get_edge_weight(T, U, V);
get_edge_weight([[V, U, W] | _], U, V) -> W;
get_edge_weight([[V, U, W] | T], U, V) -> get_edge_weight(T, U, V);
get_edge_weight([_|T], U, V) -> get_edge_weight(T, U, V).