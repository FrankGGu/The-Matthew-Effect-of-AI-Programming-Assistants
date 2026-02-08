-module(solution).
-export([max_pawns_killed/1]).

max_pawns_killed(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    DP = #{},

    Grid00 = lists:nth(1, lists:nth(1, Grid)),
    InitialDP = case Grid00 of
        2 -> DP;
        1 -> maps:put({0, 0}, 1, DP);
        0 -> maps:put({0, 0}, 0, DP)
    end,

    FinalDP = fill_dp_map(0, M, N, Grid, InitialDP),

    Result = maps:get({M - 1, N - 1}, FinalDP, -1),
    case Result of
        -1 -> 0;
        _ -> Result
    end.

fill_dp_map(R, M, N, Grid, CurrentDP) when R < M ->
    NewDP = fill_row_map(R, 0, N, Grid, CurrentDP),
    fill_dp_map(R + 1, M, N, Grid, NewDP);
fill_dp_map(_R, _M, _N, _Grid, CurrentDP) ->
    CurrentDP.

fill_row_map(R, C, N, Grid, CurrentDP) when C < N ->
    GridRC = lists:nth(C + 1, lists:nth(R + 1, Grid)),

    NewDP = case {R, C, GridRC} of
        {0, 0, _} -> CurrentDP;
        {_, _, 2} -> CurrentDP;
        {_, _, _} ->
            CurrentPawns = case GridRC of 1 -> 1; _ -> 0 end,

            FromUp = if R > 0 -> maps:get({R - 1, C}, CurrentDP, -1); true -> -1 end,
            FromLeft = if C > 0 -> maps:get({R, C - 1}, CurrentDP, -1); true -> -1 end,

            MaxPrevPawns = case {FromUp, FromLeft} of
                {-1, -1} -> -1;
                {-1, _} -> FromLeft;
                {_, -1} -> FromUp;
                {_, _} -> max(FromUp, FromLeft)
            end,

            case MaxPrevPawns of
                -1 -> CurrentDP;
                _ -> maps:put({R, C}, MaxPrevPawns + CurrentPawns, CurrentDP)
            end
    end,
    fill_row_map(R, C + 1, N, Grid, NewDP);
fill_row_map(_R, _C, _N, _Grid, CurrentDP) ->
    CurrentDP.