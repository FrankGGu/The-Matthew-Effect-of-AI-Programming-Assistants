-spec is_rectangle_overlap(Rec1 :: [integer()], Rec2 :: [integer()]) -> boolean().
is_rectangle_overlap([X1_1, Y1_1, X2_1, Y2_1], [X1_2, Y1_2, X2_2, Y2_2]) ->
    % Check for overlap in the X-axis
    XOverlap = (X1_1 < X2_2) andalso (X1_2 < X2_1),
    % Check for overlap in the Y-axis
    YOverlap = (Y1_1 < Y2_2) andalso (Y1_2 < Y2_1),
    % Rectangles overlap if and only if they overlap in both X and Y axes
    XOverlap andalso YOverlap.