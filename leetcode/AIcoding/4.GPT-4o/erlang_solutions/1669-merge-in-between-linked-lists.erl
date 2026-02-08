-module(solution).
-export([merge_in_between/3]).

-record(node, {val, next}).

merge_in_between(List1, a, b, List2) ->
    {Head1, Tail1} = split(List1, a),
    {_, Tail2} = split(List2, b),
    Head1#node.next = List2,
    Tail1#node.next = Tail2,
    Head1.

split(List, Pos) ->
    split(List, Pos, 0).

split(nil, _, _) -> {nil, nil};
split(Node, Pos, Count) when Count =:= Pos -> {Node, Node#node.next};
split(Node, Pos, Count) ->
    {H, T} = split(Node#node.next, Pos, Count + 1),
    {Node, H}.