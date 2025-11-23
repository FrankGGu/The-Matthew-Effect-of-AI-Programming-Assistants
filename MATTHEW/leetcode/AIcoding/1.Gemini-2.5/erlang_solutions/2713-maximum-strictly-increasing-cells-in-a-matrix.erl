-module(solution).
-export([max_increasing_path/1]).

max_increasing_path(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),

    Cells = lists:foldl(
        fun(RowList, AccRows) ->
            RowIdx = length(AccRows),
            RowCells = lists:foldl(
                fun(Val, AccCols) ->
                    ColIdx = length(AccCols),
                    [{Val, RowIdx, ColIdx} | AccCols]
                end, [], RowList),
            [lists:reverse(RowCells) | AccRows]
        end, [], Matrix),
    AllCells = lists:reverse(lists:flatten(Cells)),

    SortedCells = lists:sort(fun({V1, _, _}, {V2, _, _}) -> V1 < V2 end, AllCells),

    GroupedCells = lists:foldl(
        fun({Val, R, C}, Acc) ->
            case Acc of
                [] -> [[{Val, R, C}]];
                [[{HeadVal, _, _} | _] | _] = Rest when HeadVal == Val ->
                    [[{Val, R, C} | hd(Rest)] | tl(Rest)];
                _ ->
                    [[{Val, R, C}] | Acc]
            end
        end, [], SortedCells),
    ReversedGroupedCells = lists:reverse(GroupedCells),

    AnsRow = array:new([{size, M}, {fixed, true}, {default, 0}]),
    AnsCol = array:new([{size, N}, {fixed, true}, {default, 0}]),

    {FinalMaxLen, _, _} = lists:foldl(
        fun(Group, {MaxLen, CurrentAnsRow, CurrentAnsCol}) ->
            DpUpdates = lists:map(
                fun({_Val, R, C}) ->
                    RowMax = array:get(R, CurrentAnsRow),
                    ColMax = array:get(C, CurrentAnsCol),
                    DpVal = 1 + max(RowMax, ColMax),
                    {R, C, DpVal}
                end, Group),

            lists:foldl(
                fun({R, C, DpVal}, {AccMaxLen, AccAnsRow, AccAnsCol}) ->
                    NewMaxLen = max(AccMaxLen, DpVal),
                    NewAnsRow = array:set(R, max(array:get(R, AccAnsRow), DpVal), AccAnsRow),
                    NewAnsCol = array:set(C, max(array:get(C, AccAnsCol), DpVal), AccAnsCol),
                    {NewMaxLen, NewAnsRow, NewAnsCol}
                end, {MaxLen, CurrentAnsRow, CurrentAnsCol}, DpUpdates)
        end, {0, AnsRow, AnsCol}, ReversedGroupedCells),

    FinalMaxLen.