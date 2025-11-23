-spec all_cells_dist_order(R :: integer(), C :: integer(), R0 :: integer(), C0 :: integer()) -> [[integer()]].
all_cells_dist_order(R, C, R0, C0) ->
    Cells = [{I, J} || I <- lists:seq(0, R - 1), J <- lists:seq(0, C - 1)],
    Sorted = lists:sort(fun({I1, J1}, {I2, J2}) -> 
        (abs(I1 - R0) + abs(J1 - C0)) =< (abs(I2 - R0) + abs(J2 - C0)) 
    end, Cells),
    [[X, Y] || {X, Y} <- Sorted].