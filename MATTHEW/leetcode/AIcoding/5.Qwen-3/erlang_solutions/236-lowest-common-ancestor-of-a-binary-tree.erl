-module(solution).
-export([lowest_common_ancestor/2]).

-record(tree, {val, left, right}).

lowest_common_ancestor(Root, p, q) ->
    lowest_common_ancestor_helper(Root, p, q).

lowest_common_ancestor_helper(nil, _, _) ->
    nil;
lowest_common_ancestor_helper(Node, P, Q) ->
    case is_same(Node, P) of
        true ->
            Node;
        false ->
            case is_same(Node, Q) of
                true ->
                    Node;
                false ->
                    Left = lowest_common_ancestor_helper(Node#tree.left, P, Q),
                    Right = lowest_common_ancestor_helper(Node#tree.right, P, Q),
                    case Left of
                        nil ->
                            Right;
                        _ ->
                            case Right of
                                nil ->
                                    Left;
                                _ ->
                                    Node
                            end
                    end
            end
    end.

is_same(A, B) ->
    A == B.