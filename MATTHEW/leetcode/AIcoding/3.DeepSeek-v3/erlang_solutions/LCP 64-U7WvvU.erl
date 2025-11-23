-spec close_lamp_in_tree(Root :: #tree_node{} | null) -> integer().
close_lamp_in_tree(Root) ->
    case Root of
        null -> 0;
        _ -> 
            {Ans, _, _, _} = dfs(Root),
            Ans
    end.

dfs(Node) ->
    case Node of
        null -> {0, 0, 0, 0};
        _ ->
            {L0, L1, L2, L3} = dfs(Node#tree_node.left),
            {R0, R1, R2, R3} = dfs(Node#tree_node.right),
            Val = Node#tree_node.val,
            case Val of
                1 ->
                    C0 = L1 + R1 + 1,
                    C1 = min(L0, min(L2, L3)) + min(R0, min(R2, R3)) + 1,
                    C2 = min(L0, L1) + min(R0, R1) + 1,
                    C3 = min(L1, min(L0, L2)) + min(R1, min(R0, R2)) + 3,
                    {min(C0, min(C1, min(C2, C3))), C0, C1, C2};
                0 ->
                    C0 = L0 + R0,
                    C1 = min(L1, min(L2, L3)) + min(R1, min(R2, R3)) + 2,
                    C2 = min(L1, L0) + min(R1, R0) + 2,
                    C3 = min(L0, min(L1, L2)) + min(R0, min(R1, R2)) + 2,
                    {min(C0, min(C1, min(C2, C3))), C1, C0, C3}
            end
    end.