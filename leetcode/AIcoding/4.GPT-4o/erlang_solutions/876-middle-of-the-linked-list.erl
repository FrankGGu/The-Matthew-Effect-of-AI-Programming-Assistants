-module(solution).
-export([middleNode/1]).

-record(node, {val, next}).

middleNode(List) ->
    {Slow, _} = middleNode(List, List, 0),
    Slow.

middleNode(nil, nil, _) -> {nil, 0};
middleNode(nil, _, Count) -> {nil, Count};
middleNode(Node, Next, Count) ->
    case Next of
        nil -> {Node, Count};
        _ -> 
            {NextNode, NextCount} = middleNode(Node#node.next, Next#node.next#node.next, Count + 1),
            {NextNode, NextCount}
    end.