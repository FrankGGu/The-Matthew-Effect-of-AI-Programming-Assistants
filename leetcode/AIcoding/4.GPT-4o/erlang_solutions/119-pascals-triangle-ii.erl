-spec get_row(RowIndex :: integer()) -> [integer()].
get_row(RowIndex) ->
    lists:foldl(fun(_, Acc) -> next_row(Acc) end, [1], lists:seq(1, RowIndex)).

next_row(PrevRow) ->
    [1 | lists:zipwith(fun(X, Y) -> X + Y end, PrevRow, tl(PrevRow) ++ [0])].
