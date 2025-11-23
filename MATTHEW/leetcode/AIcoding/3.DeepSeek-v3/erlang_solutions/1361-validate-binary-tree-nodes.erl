-spec validate_binary_tree_nodes(N :: integer(), LeftChild :: [integer()], RightChild :: [integer()]) -> boolean().
validate_binary_tree_nodes(N, LeftChild, RightChild) ->
    InDegree = lists:duplicate(N, 0),
    UpdatedInDegree = update_in_degree(LeftChild, RightChild, InDegree),
    RootCandidates = find_root_candidates(UpdatedInDegree),
    case RootCandidates of
        [Root] -> 
            Visited = lists:duplicate(N, false),
            case dfs(Root, LeftChild, RightChild, Visited) of
                {true, NewVisited} -> 
                    lists:all(fun(X) -> X end, NewVisited);
                false -> 
                    false
            end;
        _ -> 
            false
    end.

update_in_degree(LeftChild, RightChild, InDegree) ->
    lists:foldl(fun(Child, Acc) ->
                    case Child of
                        -1 -> Acc;
                        _ -> setelement(Child + 1, Acc, element(Child + 1, Acc) + 1)
                    end
                end, InDegree, LeftChild ++ RightChild).

find_root_candidates(InDegree) ->
    lists:filtermap(fun(I) ->
                        case element(I, InDegree) of
                            0 -> {true, I - 1};
                            _ -> false
                        end
                    end, lists:seq(1, tuple_size(InDegree))).

dfs(Node, LeftChild, RightChild, Visited) ->
    case element(Node + 1, Visited) of
        true -> false;
        false ->
            NewVisited = setelement(Node + 1, Visited, true),
            Left = case lists:nth(Node + 1, LeftChild) of
                      -1 -> {true, NewVisited};
                      L -> dfs(L, LeftChild, RightChild, NewVisited)
                  end,
            case Left of
                {true, VisitedLeft} ->
                    Right = case lists:nth(Node + 1, RightChild) of
                               -1 -> {true, VisitedLeft};
                               R -> dfs(R, LeftChild, RightChild, VisitedLeft)
                           end,
                    Right;
                false -> false
            end
    end.