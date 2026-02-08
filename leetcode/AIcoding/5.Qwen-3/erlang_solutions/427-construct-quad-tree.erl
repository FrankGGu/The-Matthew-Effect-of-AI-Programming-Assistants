-module(construct_quad_tree).
-export([construct/1]).

construct([]) -> nil;
construct(Matrix) ->
    Rows = length(Matrix),
    Columns = length(hd(Matrix)),
    build_quad_tree(Matrix, 0, Rows, 0, Columns).

build_quad_tree(_, _, _, _, 0) -> nil;
build_quad_tree(Matrix, R1, R2, C1, C2) ->
    Val = get_value(Matrix, R1, R2, C1, C2),
    if
        Val == -1 -> nil;
        true ->
            IsLeaf = is_leaf(Matrix, R1, R2, C1, C2),
            if
                IsLeaf ->
                    #quad_tree{val=Val, is_leaf=true, children=[]};
                true ->
                    MidR = (R1 + R2) div 2,
                    MidC = (C1 + C2) div 2,
                    TopLeft = build_quad_tree(Matrix, R1, MidR, C1, MidC),
                    TopRight = build_quad_tree(Matrix, R1, MidR, MidC, C2),
                    BottomLeft = build_quad_tree(Matrix, MidR, R2, C1, MidC),
                    BottomRight = build_quad_tree(Matrix, MidR, R2, MidC, C2),
                    #quad_tree{val=Val, is_leaf=false, children=[TopLeft, TopRight, BottomLeft, BottomRight]}
            end
    end.

get_value(Matrix, R1, R2, C1, C2) ->
    Row = R1,
    Col = C1,
    Val = lists:nth(Row+1, Matrix),
    Val = lists:nth(Col+1, Val),
    check_all(Matrix, R1, R2, C1, C2, Val).

check_all(_, _, _, _, _, -1) -> -1;
check_all(Matrix, R1, R2, C1, C2, Val) ->
    check_rows(Matrix, R1, R2, C1, C2, Val).

check_rows(_, R, _, _, _, _) when R >= R2 -> Val;
check_rows(Matrix, R, R2, C1, C2, Val) ->
    check_cols(Matrix, R, R2, C1, C2, Val, C1).

check_cols(_, _, _, C, C2, Val, _) when C >= C2 -> Val;
check_cols(Matrix, R, R2, C, C2, Val, Col) ->
    Row = lists:nth(R+1, Matrix),
    Current = lists:nth(C+1, Row),
    if
        Current /= Val -> -1;
        true -> check_cols(Matrix, R, R2, C+1, C2, Val, Col)
    end.

is_leaf(Matrix, R1, R2, C1, C2) ->
    Val = get_value(Matrix, R1, R2, C1, C2),
    Val /= -1.

-record(quad_tree, {val, is_leaf, children}).