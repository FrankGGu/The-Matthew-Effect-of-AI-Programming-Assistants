-module(solution).
-export([max_increase_keeping_skyline/1]).

max_increase_keeping_skyline(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),

    RowMaxes = [lists:max(Row) || Row <- Grid],

    TransposedGrid = transpose(Grid),
    ColMaxes = [lists:max(Col) || Col <- TransposedGrid],

    calculate_total_increase(Grid, RowMaxes, ColMaxes, N, M).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) -> [ [H || [H|_] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].

calculate_total_increase(Grid, RowMaxes, ColMaxes, N, M) ->
    lists:foldl(fun(I, AccRow) ->
        Row = lists:nth(I + 1, Grid),
        MaxRowI = lists:nth(I + 1, RowMaxes),

        lists:foldl(fun(J, AccCol) ->
            BuildingHeight = lists:nth(J + 1, Row),
            MaxColJ = lists:nth(J + 1, ColMaxes),

            AllowedHeight = min(MaxRowI, MaxColJ),
            AccCol + (AllowedHeight - BuildingHeight)
        end, AccRow, lists:seq(0, M - 1))
    end, 0, lists:seq(0, N - 1)).