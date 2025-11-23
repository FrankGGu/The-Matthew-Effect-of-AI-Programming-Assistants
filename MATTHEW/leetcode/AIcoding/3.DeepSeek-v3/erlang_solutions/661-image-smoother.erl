-spec image_smoother(Img :: [[integer()]]) -> [[integer()]].
image_smoother(Img) ->
    Rows = length(Img),
    Cols = length(hd(Img)),
    [[smooth(I, J, Img, Rows, Cols) || J <- lists:seq(0, Cols - 1)] || I <- lists:seq(0, Rows - 1)].

smooth(I, J, Img, Rows, Cols) ->
    Sum = lists:sum([lists:nth(J1 + 1, lists:nth(I1 + 1, Img)) || 
        I1 <- lists:seq(max(0, I - 1), min(Rows - 1, I + 1)),
        J1 <- lists:seq(max(0, J - 1), min(Cols - 1, J + 1))]),
    Count = length([1 || 
        I1 <- lists:seq(max(0, I - 1), min(Rows - 1, I + 1)),
        J1 <- lists:seq(max(0, J - 1), min(Cols - 1, J + 1))]),
    Sum div Count.