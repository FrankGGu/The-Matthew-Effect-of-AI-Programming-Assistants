-module(solution).
-export([num_black_blocks/1]).

num_black_blocks(Num) ->
    num_black_blocks(Num, 0, 0, 0).

num_black_blocks(0, _, _, Acc) ->
    Acc;
num_black_blocks(N, Row, Col, Acc) ->
    case (Row + Col) rem 2 of
        0 -> num_black_blocks(N - 1, Row + 1, 0, Acc + 1);
        _ -> num_black_blocks(N - 1, Row + 1, 0, Acc)
    end.