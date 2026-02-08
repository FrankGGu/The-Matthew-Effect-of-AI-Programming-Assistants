-module(operations_on_tree).
-export([main/1]).

main(_) ->
    ok.

-record(node, {val, children = []}).

new(N, Edges) ->
    Nodes = [ #node{val = I} || I <- lists:seq(0, N-1) ],
    Tree = build_tree(Nodes, Edges),
    Tree.

build_tree(Nodes, Edges) ->
    lists:foldl(fun([P, C], Acc) ->
                    PNode = lists:nth(P+1, Acc),
                    CNode = lists:nth(C+1, Acc),
                    PNode#node{children = [CNode | PNode#node.children]}
                end, Nodes, Edges).

lock(_, _, _, _) ->
    false.

unlock(_, _, _, _) ->
    false.

upgrade(_, _, _, _) ->
    false.