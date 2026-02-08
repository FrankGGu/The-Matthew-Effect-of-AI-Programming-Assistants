-spec min_swaps(Nums :: [integer()]) -> integer().
min_swaps(Nums) ->
    TotalOnes = lists:sum(Nums),
    N = length(Nums),
    if
        TotalOnes == 0 orelse TotalOnes == N -> 0;
        true ->
            Extended = Nums ++ Nums,
            WindowSize = TotalOnes,
            {FirstWindowOnes, _} = lists:split(WindowSize, Extended),
            InitialOnes = lists:sum(FirstWindowOnes),
            min_swaps(Extended, WindowSize, 1, N + WindowSize - 1, InitialOnes, TotalOnes - InitialOnes)
    end.

min_swaps(Extended, WindowSize, Start, End, CurrentOnes, MinSwaps) when Start > End ->
    MinSwaps;
min_swaps(Extended, WindowSize, Start, End, CurrentOnes, MinSwaps) ->
    NewCurrentOnes = CurrentOnes - lists:nth(Start, Extended) + lists:nth(Start + WindowSize, Extended),
    NewMinSwaps = min(MinSwaps, WindowSize - NewCurrentOnes),
    min_swaps(Extended, WindowSize, Start + 1, End, NewCurrentOnes, NewMinSwaps).