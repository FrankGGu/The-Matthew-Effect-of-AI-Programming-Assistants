-record(quad_node, {val, is_leaf, top_left, top_right, bottom_left, bottom_right}).

-spec intersect(QuadTree1 :: #quad_node{} | null, QuadTree2 :: #quad_node{} | null) -> #quad_node{} | null.
intersect(null, null) -> null;
intersect(null, QT2) -> QT2;
intersect(QT1, null) -> QT1;
intersect(QT1, QT2) ->
    case {QT1#quad_node.is_leaf, QT2#quad_node.is_leaf} of
        {true, true} ->
            #quad_node{val = QT1#quad_node.val or QT2#quad_node.val, is_leaf = true};
        {true, false} ->
            case QT1#quad_node.val of
                true -> QT1;
                false -> QT2
            end;
        {false, true} ->
            case QT2#quad_node.val of
                true -> QT2;
                false -> QT1
            end;
        {false, false} ->
            TL = intersect(QT1#quad_node.top_left, QT2#quad_node.top_left),
            TR = intersect(QT1#quad_node.top_right, QT2#quad_node.top_right),
            BL = intersect(QT1#quad_node.bottom_left, QT2#quad_node.bottom_left),
            BR = intersect(QT1#quad_node.bottom_right, QT2#quad_node.bottom_right),
            case {TL#quad_node.is_leaf, TR#quad_node.is_leaf, BL#quad_node.is_leaf, BR#quad_node.is_leaf} of
                {true, true, true, true} ->
                    case {TL#quad_node.val, TR#quad_node.val, BL#quad_node.val, BR#quad_node.val} of
                        {V, V, V, V} -> #quad_node{val = V, is_leaf = true};
                        _ -> #quad_node{val = false, is_leaf = false, top_left = TL, top_right = TR, bottom_left = BL, bottom_right = BR}
                    end;
                _ -> #quad_node{val = false, is_leaf = false, top_left = TL, top_right = TR, bottom_left = BL, bottom_right = BR}
            end
    end.