-record(node, {val, is_leaf, top_left, top_right, bottom_left, bottom_right}).

-spec construct(Grid :: [[integer()]]) -> #node{}.
construct(Grid) ->
    construct(Grid, 0, 0, length(Grid)).

construct(Grid, X, Y, Size) ->
    case Size of
        1 ->
            #node{
                val = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
                is_leaf = true,
                top_left = null,
                top_right = null,
                bottom_left = null,
                bottom_right = null
            };
        _ ->
            Half = Size div 2,
            TopLeft = construct(Grid, X, Y, Half),
            TopRight = construct(Grid, X, Y + Half, Half),
            BottomLeft = construct(Grid, X + Half, Y, Half),
            BottomRight = construct(Grid, X + Half, Y + Half, Half),
            case {TopLeft#node.is_leaf, TopRight#node.is_leaf, BottomLeft#node.is_leaf, BottomRight#node.is_leaf} of
                {true, true, true, true} ->
                    case {TopLeft#node.val, TopRight#node.val, BottomLeft#node.val, BottomRight#node.val} of
                        {V, V, V, V} ->
                            #node{
                                val = V,
                                is_leaf = true,
                                top_left = null,
                                top_right = null,
                                bottom_left = null,
                                bottom_right = null
                            };
                        _ ->
                            #node{
                                val = true,
                                is_leaf = false,
                                top_left = TopLeft,
                                top_right = TopRight,
                                bottom_left = BottomLeft,
                                bottom_right = BottomRight
                            }
                    end;
                _ ->
                    #node{
                        val = true,
                        is_leaf = false,
                        top_left = TopLeft,
                        top_right = TopRight,
                        bottom_left = BottomLeft,
                        bottom_right = BottomRight
                    }
            end
    end.