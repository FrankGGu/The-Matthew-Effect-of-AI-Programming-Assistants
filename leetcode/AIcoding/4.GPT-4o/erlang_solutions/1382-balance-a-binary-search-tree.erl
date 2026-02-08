-module(solution).
-export([balance_bst/1]).

-record(node, {val, left = null, right = null}).

balance_bst(Root) ->
    Nodes = [],
    InOrder(Root, Nodes),
    SortedNodes = lists:sort(Nodes),
    build_tree(SortedNodes).

InOrder(null, Nodes) -> Nodes;
InOrder(#node{val=Val, left=Left, right=Right}, Nodes) ->
    InOrder(Left, [Val | InOrder(Right, Nodes)]).

build_tree([]) -> null;
build_tree(Nodes) ->
    {Left, Root, Right} = split(Nodes),
    #node{val=Root, left=build_tree(Left), right=build_tree(Right)}.

split([]) -> {[], null, []};
split([H | T]) ->
    {Left, Root, Right} = split(T),
    {Left, H, Right}.