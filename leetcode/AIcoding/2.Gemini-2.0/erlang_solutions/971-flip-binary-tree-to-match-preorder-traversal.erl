-module(flip_binary_tree).
-export([flipMatchVoyage/2]).

-spec flipMatchVoyage(TreeNode(), [integer()]) -> [integer()].
flipMatchVoyage(Root, Voyage) ->
    {Result, _} = flipMatchVoyage(Root, Voyage, 1, []),
    case lists:member(-1, Result) of
        true -> [-1];
        false -> Result
    end.

flipMatchVoyage(null, _, Index, Acc) ->
    {{Acc, Index}, null};
flipMatchVoyage(TreeNode, [], Index, Acc) ->
    {{Acc, Index}, TreeNode};
flipMatchVoyage(TreeNode, [Head | Rest], Index, Acc) ->
    case TreeNode#treeNode.val =:= Head of
        true ->
            case TreeNode#treeNode.left =:= null of
                true ->
                    flipMatchVoyage(TreeNode#treeNode.right, Rest, Index + 1, Acc);
                false ->
                    case TreeNode#treeNode.right =:= null of
                        true ->
                            flipMatchVoyage(TreeNode#treeNode.left, Rest, Index + 1, Acc);
                        false ->
                            case TreeNode#treeNode.left#treeNode.val =:= lists:nth(1, Rest) of
                                true ->
                                    {Res, _} = flipMatchVoyage(TreeNode#treeNode.left, Rest, Index + 1, Acc),
                                    case Res of
                                        {NewAcc, NewIndex} ->
                                            flipMatchVoyage(TreeNode#treeNode.right, lists:nthtail(NewIndex - (Index + 1), Rest), NewIndex, NewAcc);
                                        _ ->
                                            {{[-1], Index}, TreeNode}
                                    end;
                                false ->
                                    {Res, _} = flipMatchVoyage(TreeNode#treeNode.right, Rest, Index + 1, [TreeNode#treeNode.val | Acc]),
                                    case Res of
                                        {NewAcc, NewIndex} ->
                                            flipMatchVoyage(TreeNode#treeNode.left, lists:nthtail(NewIndex - (Index + 1), Rest), NewIndex, NewAcc);
                                        _ ->
                                            {{[-1], Index}, TreeNode}
                                    end
                            end
                    end
            end;
        false ->
            {{[-1], Index}, TreeNode}
    end.

-type TreeNode() :: null | #treeNode{val :: integer(), left :: TreeNode(), right :: TreeNode()}.
-record(treeNode, {val, left, right}).