-spec maximal_square(Matrix :: [[char()]]) -> integer().
maximal_square(Matrix) ->
    maximal_square(Matrix, []).

maximal_square([], Acc) -> Acc;
maximal_square([Row | Rest], Acc) ->
    max_side = lists:foldl(fun(Row, Acc) -> max(Acc, Row) end, 0, Row),
    maximal_square(Rest, max(max_side, Acc)).
