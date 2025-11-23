-spec is_rectangle_overlap(Rec1 :: [integer()], Rec2 :: [integer()]) -> boolean().
is_rectangle_overlap(Rec1, Rec2) ->
    [X1, Y1, X2, Y2] = Rec1,
    [A1, B1, A2, B2] = Rec2,
    X1 < A2 andalso A1 < X2 andalso Y1 < B2 andalso B1 < Y2.