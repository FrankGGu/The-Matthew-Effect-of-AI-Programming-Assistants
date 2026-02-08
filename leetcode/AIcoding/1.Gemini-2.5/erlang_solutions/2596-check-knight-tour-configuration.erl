-module(solution).
-export([check_knight_tour_configuration/1]).

check_knight_tour_configuration(Grid) ->
    N = length(Grid),
    TotalCells = N * N,

    case Grid of
        [[0 | _] | _] ->
            PosMap = build_pos_map(Grid, 0, maps:new()),
            check_path(0, TotalCells - 1, PosMap);
        _ ->
            false
    end.

build_pos_map([], _R, AccMap) ->
    AccMap;
build_pos_map([Row | RestRows], R, AccMap) ->
    NewAccMap = build_row_pos_map(Row, R, 0, AccMap),
    build_pos_map(RestRows, R + 1, NewAccMap).

build_row_pos_map([], _R, _C, AccMap) ->
    AccMap;
build_row_pos_map([Val | RestVals], R, C, AccMap) ->
    NewAccMap = maps:put(Val, {R, C}, AccMap),
    build_row_pos_map(RestVals, R, C + 1, NewAccMap).

check_path(K, MaxK, _PosMap) when K == MaxK ->
    true;
check_path(K, MaxK, PosMap) ->
    {R_K, C_K} = maps:get(K, PosMap),
    {R_K1, C_K1} = maps:get(K + 1, PosMap),

    DR = abs(R_K1 - R_K),
    DC = abs(C_K1 - C_K),

    if (DR == 1 andalso DC == 2) orelse (DR == 2 andalso DC == 1) ->
        check_path(K + 1, MaxK, PosMap);
    true ->
        false
    end.