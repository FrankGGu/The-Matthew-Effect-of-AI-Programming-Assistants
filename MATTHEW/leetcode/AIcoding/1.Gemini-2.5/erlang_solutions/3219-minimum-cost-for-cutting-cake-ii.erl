-spec minimum_cost_for_cutting_cake_ii(HorizontalCut :: [integer()], VerticalCut :: [integer()]) -> integer().
minimum_cost_for_cutting_cake_ii(HorizontalCut, VerticalCut) ->
    SortedH = lists:reverse(lists:sort(HorizontalCut)),
    SortedV = lists:reverse(lists:sort(VerticalCut)),

    solve_helper(SortedH, SortedV, 1, 1, 0).

solve_helper([], [], _NumHPieces, _NumVPieces, AccCost) ->
    AccCost;
solve_helper([], VList, NumHPieces, NumVPieces, AccCost) ->
    [VHead | VTail] = VList,
    NewAccCost = AccCost + VHead * NumHPieces,
    solve_helper([], VTail, NumHPieces, NumVPieces + 1, NewAccCost);
solve_helper(HList, [], NumHPieces, NumVPieces, AccCost) ->
    [HHead | HTail] = HList,
    NewAccCost = AccCost + HHead * NumVPieces,
    solve_helper(HTail, [], NumHPieces + 1, NumVPieces, NewAccCost);
solve_helper([HHead | HTail] = HList, [VHead | VTail] = VList, NumHPieces, NumVPieces, AccCost) ->
    if
        HHead >= VHead ->
            NewAccCost = AccCost + HHead * NumVPieces,
            solve_helper(HTail, VList, NumHPieces + 1, NumVPieces, NewAccCost);
        true -> % VHead > HHead
            NewAccCost = AccCost + VHead * NumHPieces,
            solve_helper(HList, VTail, NumHPieces, NumVPieces + 1, NewAccCost)
    end.