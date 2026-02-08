-module(solution).
-export([maximumWhiteTiles/2]).

maximumWhiteTiles(TilesList, CarpetLen) ->
    N = length(TilesList),
    if N == 0 ->
        0;
    true ->
        Tiles = array:from_list(TilesList),
        maximumWhiteTiles_loop(0, N, Tiles, CarpetLen, 0, 0, 0)
    end.

maximumWhiteTiles_loop(I, N, Tiles, CarpetLen, J, CurrentSum, MaxCovered) ->
    if I >= N ->
        MaxCovered;
    true ->
        TileI = array:get(I, Tiles),
        [TileI_L, TileI_R] = TileI,

        CarpetStart = TileI_L,
        CarpetEnd = CarpetStart + CarpetLen - 1,

        % Advance the right pointer J and update CurrentSum
        {NewJ, NewCurrentSum} = advance_j(J, N, Tiles, CarpetEnd, CurrentSum),

        % Calculate the actual coverage for the current carpet placement
        CoveredByCurrentCarpet = calculate_coverage(NewJ, Tiles, CarpetEnd, NewCurrentSum),

        NewMaxCovered = max(MaxCovered, CoveredByCurrentCarpet),

        % Remove the contribution of TileI for the next iteration (when I moves to I+1)
        TileI_Length = TileI_R - TileI_L + 1,
        NextCurrentSum = NewCurrentSum - TileI_Length,

        maximumWhiteTiles_loop(I + 1, N, Tiles, CarpetLen, NewJ, NextCurrentSum, NewMaxCovered)
    end.

advance_j(J, N, Tiles, CarpetEnd, CurrentSum) ->
    if J < N ->
        TileJ = array:get(J, Tiles),
        [TileJ_L, TileJ_R] = TileJ,
        if TileJ_L <= CarpetEnd ->
            TileJ_Length = TileJ_R - TileJ_L + 1,
            advance_j(J + 1, N, Tiles, CarpetEnd, CurrentSum + TileJ_Length);
        true ->
            {J, CurrentSum}
        end;
    true ->
        {J, CurrentSum}
    end.

calculate_coverage(J, Tiles, CarpetEnd, CurrentSum) ->
    if J > 0 ->
        TileJ_minus_1 = array:get(J - 1, Tiles),
        [_TileJ_minus_1_L, TileJ_minus_1_R] = TileJ_minus_1,
        OverlapWithRightmostTile = max(0, TileJ_minus_1_R - CarpetEnd),
        CurrentSum - OverlapWithRightmostTile;
    true ->
        % If J is 0, no tiles were covered, so CurrentSum is 0.
        CurrentSum 
    end.

max(A, B) when A >= B -> A;
max(A, B) -> B.