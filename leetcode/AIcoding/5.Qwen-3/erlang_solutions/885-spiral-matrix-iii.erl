-module(spiral_matrix_iii).
-export([spiralMatrixIII/3]).

spiralMatrixIII(Height, Width, Steps) ->
    Direction = [{0,1}, {1,0}, {0,-1}, {-1,0}],
    spiral_matrix_iii(Height, Width, Steps, 0, 0, 0, 0, Direction, []).

spiral_matrix_iii(_Height, _Width, 0, _Row, _Col, _Dir, _Step, _DirList, Acc) ->
    lists:reverse(Acc);
spiral_matrix_iii(Height, Width, Steps, Row, Col, Dir, Step, DirList, Acc) ->
    if
        Row >= 0, Row < Height, Col >= 0, Col < Width ->
            spiral_matrix_iii(Height, Width, Steps-1, next_row(Row, element(Dir+1, DirList)), next_col(Col, element(Dir+1, DirList)), Dir, Step+1, DirList, [ {Row, Col} | Acc ]);
        true ->
            spiral_matrix_iii(Height, Width, Steps, Row, Col, (Dir+1) rem 4, Step, DirList, Acc)
    end.

next_row(Row, {Dr, _Dc}) -> Row + Dr.
next_col(Col, {_Dr, Dc}) -> Col + Dc.