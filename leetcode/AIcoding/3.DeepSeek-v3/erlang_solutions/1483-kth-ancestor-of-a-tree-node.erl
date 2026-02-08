-module(kth_ancestor).

-export([init/1, getKthAncestor/3]).

-record(node, {parent, ancestors}).

init(N, Parent) ->
    Nodes = array:new(N, {default, #node{parent = -1, ancestors = []}}),
    lists:foldl(fun(I, Acc) ->
        P = lists:nth(I + 1, Parent),
        Ancestors = case P of
            -1 -> [];
            _ ->
                PNode = array:get(P, Acc),
                [P | PNode#node.ancestors]
        end,
        array:set(I, #node{parent = P, ancestors = Ancestors}, Acc)
    end, Nodes, lists:seq(0, N - 1)).

getKthAncestor(Node, K, Nodes) ->
    case K =:= 0 of
        true -> Node;
        false ->
            Ancestors = (array:get(Node, Nodes))#node.ancestors,
            case K > length(Ancestors) of
                true -> -1;
                false -> lists:nth(K, Ancestors)
            end
    end.