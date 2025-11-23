-module(solution).
-export([printTree/1]).

-record(tree_node, {val, left, right}).

height(null) -> -1;
height(#tree_node{left=L, right=R}) -> 1 + max(height(L), height(R)).

pow(_, 0) -> 1;
pow(Base, Exp) when Exp > 0 -> Base * pow(Base, Exp - 1).

set_cell(Matrix, RowIdx, ColIdx, Value) ->
    RowList = lists:nth(RowIdx + 1, Matrix),
    NewRowList = lists:replace_nth(ColIdx + 1, Value, RowList),
    lists:replace_nth(RowIdx + 1, NewRowList, Matrix).

place(null, _, _, _, AccMatrix) ->
    AccMatrix;
place(#tree_node{val=Val, left=L, right=R}, R, C, H, AccMatrix) ->
    MatrixWithCurrent = set_cell(AccMatrix, R, C, integer_to_list(Val)),
    if R < H ->
        Offset = pow(2, H - R - 1),
        MatrixWithLeft = place(L, R + 1, C - Offset, H, MatrixWithCurrent),
        place(R, R + 1, C + Offset, H, MatrixWithLeft);
    true ->
        MatrixWithCurrent
    end.

printTree(Root) ->
    H = height(Root),
    M = H + 1,
    N = pow(2, H + 1) - 1,
    InitialMatrix = lists:duplicate(M, lists:duplicate(N, "")),
    place(Root, 0, (N - 1) div 2, H, InitialMatrix).