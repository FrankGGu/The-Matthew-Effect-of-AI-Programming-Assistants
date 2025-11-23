-spec is_boomerang([[integer()]]) -> boolean().
is_boomerang(Points) ->
    [[X1, Y1], [X2, Y2], [X3, Y3]] = Points,
    (Y2 - Y1) * (X3 - X1) =/= (Y3 - Y1) * (X2 - X1).