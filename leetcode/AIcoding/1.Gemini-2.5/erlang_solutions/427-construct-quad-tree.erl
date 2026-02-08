-module(solution).
-export([construct/1]).

-record(node, {val, isLeaf, topLeft, topRight, bottomLeft, bottomRight}).

construct(Grid) ->
    N = length(Grid),
    construct_recursive(Grid, 0, 0, N).

construct_recursive(Grid, R, C, Size) ->
    if Size == 1 ->
        Row = lists:nth(R + 1, Grid),
        Val = lists:nth(C + 1, Row),
        #node{val = (Val == 1), isLeaf = true, topLeft = null, topRight = null, bottomLeft = null, bottomRight = null};
    true ->
        FirstVal = get_grid_val(Grid, R, C),
        IsAllSame = check_all_same(Grid, R, C, Size, FirstVal),

        if IsAllSame ->
            #node{val = (FirstVal == 1), isLeaf = true, topLeft = null, topRight = null, bottomLeft = null, bottomRight = null};
        true ->
            HalfSize = Size div 2,
            TL = construct_recursive(Grid, R, C, HalfSize),
            TR = construct_recursive(Grid, R, C + HalfSize, HalfSize),
            BL = construct_recursive(Grid, R + HalfSize, C, HalfSize),
            BR = construct_recursive(Grid, R + HalfSize, C + HalfSize, HalfSize),
            #node{val = false, isLeaf = false, topLeft = TL, topRight = TR, bottomLeft = BL, bottomRight = BR}
        end
    end.

get_grid_val(Grid, R, C) ->
    Row = lists:nth(R + 1, Grid),
    lists:nth(C + 1, Row).

check_all_same(Grid, R, C, Size, ExpectedVal) ->
    check_all_same_rows(Grid, R, C, Size, ExpectedVal, 0).

check_all_same_rows(Grid, R, C, Size, ExpectedVal, CurrentRowOffset) ->
    if CurrentRowOffset == Size ->
        true;
    true ->
        Row = lists:nth(R + CurrentRowOffset + 1, Grid),
        IsRowSame = check_all_same_cols(Row, C, Size, ExpectedVal, 0),
        if IsRowSame == false ->
            false;
        true ->
            check_all_same_rows(Grid, R, C, Size, ExpectedVal, CurrentRowOffset + 1)
        end
    end.

check_all_same_cols(Row, C, Size, ExpectedVal, CurrentColOffset) ->
    if CurrentColOffset == Size ->
        true;
    true ->
        Val = lists:nth(C + CurrentColOffset + 1, Row),
        if Val /= ExpectedVal ->
            false;
        true ->
            check_all_same_cols(Row, C, Size, ExpectedVal, CurrentColOffset + 1)
        end
    end.