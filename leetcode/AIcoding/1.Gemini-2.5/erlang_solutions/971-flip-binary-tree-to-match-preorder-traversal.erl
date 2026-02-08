-record(tree_node, {val=0, left=nil, right=nil}).

-spec flip_match_voyage(Root :: tree_node() | nil, Voyage :: [integer()]) -> [integer()].
flip_match_voyage(Root, Voyage) ->
    case dfs(Root, Voyage, []) of
        {ok, [], Flips} ->
            lists:reverse(Flips);
        _ ->
            [-1]
    end.

dfs(nil, VoyageList, AccFlips) ->
    {ok, VoyageList, AccFlips};
dfs(Node, [H | T] = VoyageList, AccFlips) when is_record(Node, tree_node) ->
    Val = Node#tree_node.val,
    Left = Node#tree_node.left,
    Right = Node#tree_node.right,

    if
        Val =/= H ->
            error;
        true ->
            case {Left, Right} of
                {nil, nil} ->
                    {ok, T, AccFlips};
                {L, nil} when is_record(L, tree_node) ->
                    case dfs(L, T, AccFlips) of
                        {ok, RemainingVoyage, IntermediateFlips} ->
                            {ok, RemainingVoyage, IntermediateFlips};
                        error -> error
                    end;
                {nil, R} when is_record(R, tree_node) ->
                    case dfs(R, T, AccFlips) of
                        {ok, RemainingVoyage, IntermediateFlips} ->
                            {ok, RemainingVoyage, IntermediateFlips};
                        error -> error
                    end;
                {L, R} when is_record(L, tree_node), is_record(R, tree_node) ->
                    case T of
                        [] ->
                            error;
                        [NextVal | _] ->
                            if
                                L#tree_node.val =:= NextVal ->
                                    case dfs(L, T, AccFlips) of
                                        {ok, RemainingVoyageL, IntermediateFlipsL} ->
                                            dfs(R, RemainingVoyageL, IntermediateFlipsL);
                                        error -> error
                                    end;
                                R#tree_node.val =:= NextVal ->
                                    case dfs(R, T, [Val | AccFlips]) of
                                        {ok, RemainingVoyageR, IntermediateFlipsR} ->
                                            dfs(L, RemainingVoyageR, IntermediateFlipsR);
                                        error -> error
                                    end;
                                true ->
                                    error
                            end
                    end
            end
    end;
dfs(Node, [], _AccFlips) when is_record(Node, tree_node) ->
    error.