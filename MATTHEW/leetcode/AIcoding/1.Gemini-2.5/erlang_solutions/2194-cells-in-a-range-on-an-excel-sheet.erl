-spec cells_in_range(S :: string()) -> [string()].
cells_in_range([C1, R1, $:, C2, R2]) ->
    [ [C, R] || C <- lists:seq(C1, C2), R <- lists:seq(R1, R2) ].