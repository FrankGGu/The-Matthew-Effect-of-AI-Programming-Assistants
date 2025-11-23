-module(flip_binary_tree_to_match_preorder_traversal).
-export([flipMatchV2/2]).

flipMatchV2(Root, Voyage) ->
    Result = [],
    {Result, _} = dfs(Root, Voyage, 0, Result),
    Result.

dfs(nil, _, _, Acc) ->
    {Acc, true};
dfs(#{} = Node, [Val | Rest], Index, Acc) when Val == Node#node.val ->
    case dfs(Node#node.left, Rest, Index + 1, Acc) of
        {NewAcc, true} ->
            case dfs(Node#node.right, Rest, Index + 1, NewAcc) of
                {FinalAcc, true} ->
                    {FinalAcc, true};
                {FinalAcc, false} ->
                    {FinalAcc, false}
            end;
        {NewAcc, false} ->
            {NewAcc, false}
    end;
dfs(#{} = Node, [Val | Rest], Index, Acc) ->
    case dfs(Node#node.right, Rest, Index + 1, Acc) of
        {NewAcc, true} ->
            case dfs(Node#node.left, Rest, Index + 1, [Node#node.val | NewAcc]) of
                {FinalAcc, true} ->
                    {FinalAcc, true};
                {FinalAcc, false} ->
                    {FinalAcc, false}
            end;
        {NewAcc, false} ->
            {NewAcc, false}
    end.