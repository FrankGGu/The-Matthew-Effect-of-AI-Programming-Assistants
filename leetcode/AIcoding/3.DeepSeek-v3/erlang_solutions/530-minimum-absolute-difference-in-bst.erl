-spec get_minimum_difference(#tree_node{} | null) -> integer().
get_minimum_difference(Root) ->
    {Min, _} = traverse(Root, -1, {infinity, -1}),
    Min.

traverse(null, _Prev, {Min, _PrevVal}) ->
    {Min, _Prev};
traverse(#tree_node{val = Val, left = Left, right = Right}, Prev, {Min, PrevVal}) ->
    {NewMin, NewPrev} = traverse(Left, Prev, {Min, PrevVal}),
    CurrentMin = case NewPrev of
                    -1 -> NewMin;
                    _ -> min(NewMin, Val - NewPrev)
                  end,
    traverse(Right, Val, {CurrentMin, Val}).