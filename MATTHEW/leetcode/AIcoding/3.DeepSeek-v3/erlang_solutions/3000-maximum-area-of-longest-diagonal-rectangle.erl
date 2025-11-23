-spec area_of_max_diagonal(Dim :: [[integer()]]) -> integer().
area_of_max_diagonal(Dim) ->
    F = fun([L, W], {MaxDiag, MaxArea}) ->
            Diag = L * L + W * W,
            Area = L * W,
            if
                Diag > MaxDiag -> {Diag, Area};
                Diag == MaxDiag andalso Area > MaxArea -> {Diag, Area};
                true -> {MaxDiag, MaxArea}
            end
        end,
    {_, Res} = lists:foldl(F, {0, 0}, Dim),
    Res.