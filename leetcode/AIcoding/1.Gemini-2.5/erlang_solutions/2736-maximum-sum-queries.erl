-module(solution).
-export([maximumSumQueries/3]).

maximumSumQueries(Nums1, Nums2, Queries) ->
    Points = lists:zip(Nums1, Nums2),
    SortedPointsList = lists:sort(fun({A1, _}, {B1, _}) -> A1 >= B1 end, Points),
    SortedPointsArray = array:from_list(SortedPointsList),

    QueryTuples = lists:zip(Queries, lists:seq(0, length(Queries) - 1)),
    SortedQueries = lists:sort(fun({{A_X, _}, _}, {{B_X, _}, _}) -> A_X >= B_X end, QueryTuples),

    AllN2sList = lists:usort(lists:map(fun({_, N2}) -> N2 end, Points)),
    MaxN2Idx = length(AllN2sList) - 1,
    UniqueN2sArray = array:from_list(AllN2sList),

    N2_to_Idx_Map = gb_trees:from_list(lists:zip(AllN2sList, lists:seq(0, MaxN2Idx))),

    InitialSegTree = seg_tree_new(MaxN2Idx + 1),

    InitialResults = array:new([{size, length(Queries)}, {fixed, true}, {default, -1}]),

    {FinalResultsArray, _} = sweep(SortedQueries, SortedPointsArray, 0, InitialSegTree, N2_to_Idx_Map, UniqueN2sArray, MaxN2Idx, InitialResults),

    array:to_list(FinalResultsArray).

seg_tree_new(Size) ->
    array:new([{size, 4 * Size}, {fixed, true}, {default, -1}]).

seg_tree_update(Tree, N2_to_Idx_Map, P_N1, P_N2, MaxIdx) ->
    Idx = gb_trees:get(P_N2, N2_to_Idx_Map),
    seg_tree_update_node(Tree, 0, 0, MaxIdx, Idx, P_N1 + P_N2).

seg_tree_update_node(Tree, NodeIdx, Low, High, TargetIdx, Val) ->
    if Low == High ->
        array:set(NodeIdx, max(array:get(NodeIdx, Tree), Val), Tree);
    true ->
        Mid = Low + (High - Low) div 2,
        NewTree = if TargetIdx <= Mid ->
                      seg_tree_update_node(Tree, 2 * NodeIdx + 1, Low, Mid, TargetIdx, Val);
                  true ->
                      seg_tree_update_node(Tree, 2 * NodeIdx + 2, Mid + 1, High, TargetIdx, Val)
                  end,
        LeftVal = array:get(2 * NodeIdx + 1, NewTree),
        RightVal = array:get(2 * NodeIdx + 2, NewTree),
        array:set(NodeIdx, max(LeftVal, RightVal), NewTree)
    end.

seg_tree_query(Tree, QueryLowIdx, MaxIdx) ->
    seg_tree_query_node(Tree, 0, 0, MaxIdx, QueryLowIdx, MaxIdx).

seg_tree_query_node(Tree, NodeIdx, Low, High, QueryLow, QueryHigh) ->
    if QueryLow > High; QueryHigh < Low ->
        -1;
    true when QueryLow <= Low andalso High <= QueryHigh ->
        array:get(NodeIdx, Tree);
    true ->
        Mid = Low + (High - Low) div 2,
        LeftMax = seg_tree_query_node(Tree, 2 * NodeIdx + 1, Low, Mid, QueryLow, QueryHigh),
        RightMax = seg_tree_query_node(Tree, 2 * NodeIdx + 2, Mid + 1, High, QueryLow, QueryHigh),
        max(LeftMax, RightMax)
    end.

find_n2_idx_for_y(Y, UniqueN2sArray) ->
    Len = array:size(UniqueN2sArray),
    find_n2_idx_for_y_bs(Y, UniqueN2sArray, 0, Len - 1, Len).

find_n2_idx_for_y_bs(Y, UniqueN2sArray, Low, High, Ans) when Low > High -> Ans;
find_n2_idx_for_y_bs(Y, UniqueN2sArray, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    MidVal = array:get(Mid, UniqueN2sArray),
    case MidVal of
        V when V >= Y ->
            find_n2_idx_for_y_bs(Y, UniqueN2sArray, Low, Mid - 1, Mid);
        _ ->
            find_n2_idx_for_y_bs(Y, UniqueN2sArray, Mid + 1, High, Ans)
    end.

sweep([], _SortedPointsArray, PointPointer, SegTree, _N2_to_Idx_Map, _UniqueN2sArray, _MaxN2Idx, Results) ->
    {Results, SegTree};
sweep([{Query, OriginalIdx} | RestQueries], SortedPointsArray, PointPointer, SegTree, N2_to_Idx_Map, UniqueN2sArray, MaxN2Idx, Results) ->
    {X, Y} = Query,

    {NewSegTree, NewPointPointer} = process_points_for_query(SortedPointsArray, PointPointer, X, SegTree, N2_to_Idx_Map, MaxN2Idx),

    Y_Idx = find_n2_idx_for_y(Y, UniqueN2sArray),

    UpdatedResults = if Y_Idx < MaxN2Idx + 1 ->
                         MaxSum = seg_tree_query(NewSegTree, Y_Idx, MaxN2Idx),
                         if MaxSum /= -1 ->
                             array:set(OriginalIdx, MaxSum, Results);
                         true ->
                             Results
                         end;
                     true ->
                         Results
                     end,

    sweep(RestQueries, SortedPointsArray, NewPointPointer, NewSegTree, N2_to_Idx_Map, UniqueN2sArray, MaxN2Idx, UpdatedResults).

process_points_for_query(SortedPointsArray, PointPointer, X, SegTree, N2_to_Idx_Map, MaxN2Idx) ->
    LenPoints = array:size(SortedPointsArray),
    process_points_loop(SortedPointsArray, PointPointer, LenPoints, X, SegTree, N2_to_Idx_Map, MaxN2Idx).

process_points_loop(SortedPointsArray, PointPointer, LenPoints, X, SegTree, N2_to_Idx_Map, MaxN2Idx) when PointPointer < LenPoints ->
    {P_N1, P_N2} = array:get(PointPointer, SortedPointsArray),
    if P_N1 >= X ->
        NewSegTree = seg_tree_update(SegTree, N2_to_Idx_Map, P_N1, P_N2, MaxN2Idx),
        process_points_loop(SortedPointsArray, PointPointer + 1, LenPoints, X, NewSegTree, N2_to_Idx_Map, MaxN2Idx);
    true ->
        {SegTree, PointPointer}
    end;
process_points_loop(_SortedPointsArray, PointPointer, _LenPoints, _X, SegTree, _N2_to_Idx_Map, _MaxN2Idx) ->
    {SegTree, PointPointer}.