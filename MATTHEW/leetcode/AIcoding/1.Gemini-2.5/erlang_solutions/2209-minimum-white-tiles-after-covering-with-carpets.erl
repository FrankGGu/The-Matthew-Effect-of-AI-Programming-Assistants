-module(solution).
-export([minimum_white_tiles/3]).

minimum_white_tiles(Floor, NumCarpets, CarpetLen) ->
    N = length(Floor),
    FloorList = [if C == $0 -> 0; C == $1 -> 1 end || C <- string:chars(Floor)],
    FloorTuple = list_to_tuple(FloorList), % Convert to tuple for O(1) access

    % Precompute prefix sums of white tiles
    % PrefixWhite[i] stores the count of '0's in Floor[0...i-1]
    % Using array module for efficient access
    PrefixWhite = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),
    PrefixWhite_0 = array:set(0, 0, PrefixWhite),
    PrefixWhite_final = calculate_prefix_white(1, N, FloorTuple, PrefixWhite_0),

    % DP table: dp[i][j] = minimum white tiles remaining in Floor[0...i-1] using j carpets
    % DP is an array of arrays
    DP = array:new([{size, N + 1}, {fixed, true}, {default, array:new([{size, NumCarpets + 1}, {fixed, true}, {default, 0}])}]),

    % Initialize base cases:
    % dp[0][j] = 0 for all j (no floor, no white tiles)
    % dp[i][0] = PrefixWhite[i] for all i (no carpets, all white tiles remain)
    DP_init_0 = array:set(0, array:new([{size, NumCarpets + 1}, {fixed, true}, {default, 0}]), DP),
    DP_init_rows = initialize_dp_rows(1, N, NumCarpets, PrefixWhite_final, DP_init_0),

    % Fill DP table
    DP_final = fill_dp(1, N, 1, NumCarpets, CarpetLen, FloorTuple, DP_init_rows),

    array:get(NumCarpets, array:get(N, DP_final)).

calculate_prefix_white(I, N, FloorTuple, AccPrefixWhite) when I =< N ->
    FloorChar = element(I, FloorTuple), % FloorChar is floor[I-1]
    Val = if FloorChar == 0 -> 1; true -> 0 end,
    NewVal = array:get(I - 1, AccPrefixWhite) + Val,
    NewAccPrefixWhite = array:set(I, NewVal, AccPrefixWhite),
    calculate_prefix_white(I + 1, N, FloorTuple, NewAccPrefixWhite);
calculate_prefix_white(_I, _N, _FloorTuple, AccPrefixWhite) ->
    AccPrefixWhite.

initialize_dp_rows(I, N, NumCarpets, PrefixWhite, AccDP) when I =< N ->
    Row_j0 = array:get(I, PrefixWhite),
    Row = array:new([{size, NumCarpets + 1}, {fixed, true}, {default, 0}]),
    Row_init = array:set(0, Row_j0, Row),
    NewAccDP = array:set(I, Row_init, AccDP),
    initialize_dp_rows(I + 1, N, NumCarpets, PrefixWhite, NewAccDP);
initialize_dp_rows(_I, _N, _NumCarpets, _PrefixWhite, AccDP) ->
    AccDP.

fill_dp(I, N, J, NumCarpets, CarpetLen, FloorTuple, AccDP) when I =< N ->
    % Iterate J for current I
    DP_row_filled_J = fill_dp_row_j(I, J, NumCarpets, CarpetLen, FloorTuple, AccDP),
    fill_dp(I + 1, N, 1, NumCarpets, CarpetLen, FloorTuple, DP_row_filled_J);
fill_dp(_I, _N, _J, _NumCarpets, _CarpetLen, _FloorTuple, AccDP) ->
    AccDP.

fill_dp_row_j(I, J, NumCarpets, CarpetLen, FloorTuple, AccDP) when J =< NumCarpets ->
    FloorChar = element(I, FloorTuple), % Floor[I-1]

    % Option 1: Don't use a carpet that covers tile Floor[I-1]
    Option1_prev_dp_val = array:get(J, array:get(I - 1, AccDP)),
    Option1_current_tile_cost = if FloorChar == 0 -> 1; true -> 0 end,
    Option1 = Option1_prev_dp_val + Option1_current_tile_cost,

    % Option 2: Use a carpet that covers tile Floor[I-1]
    % This carpet covers Floor[max(0, I-CarpetLen)...I-1]
    PrevI = max(0, I - CarpetLen),
    Option2 = array:get(J - 1, array:get(PrevI, AccDP)),

    MinVal = min(Option1, Option2),

    CurrentRow = array:get(I, AccDP),
    NewCurrentRow = array:set(J, MinVal, CurrentRow),
    NewAccDP = array:set(I, NewCurrentRow, AccDP),

    fill_dp_row_j(I, J + 1, NumCarpets, CarpetLen, FloorTuple, NewAccDP);
fill_dp_row_j(_I, _J, _NumCarpets, _CarpetLen, _FloorTuple, AccDP) ->
    AccDP.