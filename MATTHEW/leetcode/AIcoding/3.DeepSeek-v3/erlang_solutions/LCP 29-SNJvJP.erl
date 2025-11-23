-spec orchestra_layout(N :: integer(), X :: integer(), Y :: integer()) -> integer().
orchestra_layout(N, X, Y) ->
    Layer = min(min(X, N - 1 - X), min(Y, N - 1 - Y)),
    OuterSize = N * N - (N - 2 * Layer) * (N - 2 * Layer),
    if
        X == Layer ->
            Pos = Y - Layer + OuterSize;
        Y == N - 1 - Layer ->
            Pos = (N - 2 * Layer - 1) + (X - Layer) + OuterSize;
        X == N - 1 - Layer ->
            Pos = 2 * (N - 2 * Layer - 1) + (N - 1 - Layer - Y) + OuterSize;
        Y == Layer ->
            Pos = 3 * (N - 2 * Layer - 1) + (N - 1 - Layer - X) + OuterSize
    end,
    (Pos - 1) rem 9 + 1.