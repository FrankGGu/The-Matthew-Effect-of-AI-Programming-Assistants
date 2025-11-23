-module(solution).
-export([rotate_the_box/1]).

rotate_the_box(Box) ->
    Rotated = rotate(Box),
    [gravity(Row) || Row <- Rotated].

rotate(Box) ->
    Rows = length(Box),
    Cols = length(hd(Box)),
    [[lists:nth(Row, lists:nth(Col, Box)) || Row <- lists:reverse(lists:seq(1, Rows))] || Col <- lists:seq(1, Cols)].

gravity(Row) ->
    {Processed, _} = lists:foldr(fun
        ($*, {Acc, Pos}) -> {[$* | Acc], Pos};
        ($#, {Acc, Pos}) -> {lists:duplicate(Pos - length(Acc) ++ [$# | Acc], Pos - 1)};
        ($., {Acc, Pos}) -> {Acc, Pos}
    end, {[], length(Row)}, Row),
    Processed.