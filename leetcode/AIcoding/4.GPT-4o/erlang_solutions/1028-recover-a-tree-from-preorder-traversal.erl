-module(solution).
-export([recover_from_preorder/1]).

-record(node, {val, left = none, right = none}).

recover_from_preorder(Traversal) ->
    recover_from_preorder(Traversal, 0, [], []).

recover_from_preorder([], _, [], _) -> none;
recover_from_preorder(Traversal, Depth, [H | T], Acc) when Depth > H#node.val ->
    recover_from_preorder(Traversal, Depth, T, [H | Acc]);
recover_from_preorder(Traversal, Depth, [], Acc) ->
    recover_from_preorder(Traversal, Depth, [#node{val = 0}], Acc);
recover_from_preorder(Traversal, Depth, [H | T], Acc) ->
    case T of
        [] -> none;
        [Next | _] ->
            NextDepth = count_depth(Next),
            case NextDepth of
                Depth + 1 -> 
                    NewNode = #node{val = Next},
                    recover_from_preorder(Traversal, Depth + 1, [NewNode | T], Acc);
                _ -> 
                    recover_from_preorder(Traversal, Depth, T, Acc)
            end
    end.

count_depth(0) -> 0;
count_depth(Depth) -> count_depth(Depth div 10) + 1.

build_tree([]) -> none;
build_tree([H | T]) ->
    Node = #node{val = H},
    {Node, build_tree(T)}.