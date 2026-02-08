-spec valid_square(P1 :: [integer()], P2 :: [integer()], P3 :: [integer()], P4 :: [integer()]) -> boolean().
valid_square(P1, P2, P3, P4) ->
    Points = [P1, P2, P3, P4],
    UniquePoints = lists:usort(Points),
    case length(UniquePoints) of
        4 ->
            Distances = lists:sort([dist_squared(A, B) || A <- Points, B <- Points, A =/= B]),
            [D1, D2, D3, D4, D5, D6 | _] = Distances,
            D1 > 0 andalso D1 == D2 andalso D1 == D3 andalso D1 == D4 andalso D5 == D6 andalso D5 == 2 * D1;
        _ ->
            false
    end.

dist_squared([X1, Y1], [X2, Y2]) ->
    (X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1).