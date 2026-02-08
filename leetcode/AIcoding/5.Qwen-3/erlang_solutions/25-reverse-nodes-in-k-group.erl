-module(reverse_nodes_in_k_group).
-export([reverseKGroup/2]).

reverseKGroup(_Head, _K) -> [].

reverseKGroup(Head, K) ->
    reverseKGroup(Head, K, []).

reverseKGroup(Head, K, Acc) ->
    case getKNodes(Head, K) of
        {[], _} -> lists:reverse(Acc) ++ Head;
        {KNodes, Rest} ->
            reverseKGroup(Rest, K, [lists:reverse(KNodes) | Acc])
    end.

getKNodes(List, 0) -> {[], List};
getKNodes([], _) -> {[], []};
getKNodes([H|T], N) ->
    {Nodes, Rest} = getKNodes(T, N-1),
    {[H|Nodes], Rest}.