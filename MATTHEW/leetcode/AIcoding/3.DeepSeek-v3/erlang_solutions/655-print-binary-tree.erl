-spec print_tree(Root :: tree_node() | null) -> [[list()]].
print_tree(Root) ->
    case Root of
        null -> [];
        _ ->
            Height = get_height(Root),
            Cols = trunc(math:pow(2, Height) - 1,
            Matrix = lists:duplicate(Height, lists:duplicate(Cols, "")),
            fill_matrix(Root, 0, 0, Cols - 1, Matrix)
    end.

get_height(null) -> 0;
get_height(Node) ->
    1 + max(get_height(maps:get(left, Node, null)), get_height(maps:get(right, Node, null))).

fill_matrix(Node, Row, Left, Right, Matrix) ->
    Mid = (Left + Right) div 2,
    NewMatrix = set_matrix_element(Row, Mid, integer_to_list(maps:get(val, Node)), Matrix),
    NewMatrix1 = case maps:get(left, Node, null) of
        null -> NewMatrix;
        LeftNode -> fill_matrix(LeftNode, Row + 1, Left, Mid - 1, NewMatrix)
    end,
    case maps:get(right, Node, null) of
        null -> NewMatrix1;
        RightNode -> fill_matrix(RightNode, Row + 1, Mid + 1, Right, NewMatrix1)
    end.

set_matrix_element(Row, Col, Value, Matrix) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = lists:sublist(RowList, Col) ++ [Value] ++ lists:nthtail(Col + 1, RowList),
    lists:sublist(Matrix, Row) ++ [NewRowList] ++ lists:nthtail(Row + 1, Matrix).