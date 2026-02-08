-spec min_flips(Grid :: [[integer()]]) -> integer().
min_flips(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    HalfN = (N + 1) div 2,
    HalfM = (M + 1) div 2,
    Flips = 0,
    min_flips(Grid, N, M, HalfN, HalfM, 0, 0, Flips).

min_flips(Grid, N, M, HalfN, HalfM, I, J, Flips) when I < HalfN ->
    case J < HalfM of
        true ->
            Cell1 = lists:nth(I + 1, lists:nth(J + 1, Grid)),
            Cell2 = lists:nth(I + 1, lists:nth(M - J, Grid)),
            Cell3 = lists:nth(N - I, lists:nth(J + 1, Grid)),
            Cell4 = lists:nth(N - I, lists:nth(M - J, Grid)),
            Sum = Cell1 + Cell2 + Cell3 + Cell4,
            NewFlips = case Sum of
                2 -> Flips + 2;
                _ -> Flips + min(Sum, 4 - Sum)
            end,
            min_flips(Grid, N, M, HalfN, HalfM, I, J + 1, NewFlips);
        false ->
            min_flips(Grid, N, M, HalfN, HalfM, I + 1, 0, Flips)
    end;
min_flips(_Grid, _N, _M, _HalfN, _HalfM, _I, _J, Flips) ->
    Flips.