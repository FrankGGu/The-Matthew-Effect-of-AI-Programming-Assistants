-spec is_boomerang(Points :: [[integer(), integer()]]) -> boolean().
is_boomerang([[X1, Y1], [X2, Y2], [X3, Y3]]) ->
    (X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1 - Y2)) =/= 0.