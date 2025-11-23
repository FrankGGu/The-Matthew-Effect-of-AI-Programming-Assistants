-module(equal_sum_grid_partition_i).
-export([equal_sum_grid_partition/1]).

equal_sum_grid_partition(Grid) ->
    N = length(Grid),
    PrefixSum = [[0 || _ <- lists:seq(0, N)] || _ <- lists:seq(0, N)],
    PrefixSumUpdated = update_prefix_sum(Grid, PrefixSum, N),

    can_partition(PrefixSumUpdated, 0, 0, N, N).

update_prefix_sum(Grid, PrefixSum, N) ->
    lists:foldl(
        fun(I, AccPrefixSum) ->
            lists:foldl(
                fun(J, AccPrefixSum2) ->
                    AccPrefixSum2#{
                        {I, J} => element(J + 1, element(I + 1, Grid)) +
                                    (maps:get({I-1, J}, AccPrefixSum2, 0) +
                                     maps:get({I, J-1}, AccPrefixSum2, 0) -
                                     maps:get({I-1, J-1}, AccPrefixSum2, 0))
                    }
                end,
                AccPrefixSum,
                lists:seq(0, N - 1)
            )
        end,
        maps:from_list([{I,J} => element(J+1, element(I+1, Grid)) || I <- [-1, N], J <- [-1, N] ]),
        lists:seq(0, N - 1)
    ).

can_partition(PrefixSum, Row, Col, N, GridSize) ->
    if Row >= GridSize orelse Col >= GridSize then
        false
    else
        case Row of
            0 ->
                case Col of
                    0 ->
                        check_horizontal(PrefixSum, Row, Col, N, GridSize) orelse
                        check_vertical(PrefixSum, Row, Col, N, GridSize);
                    _ ->
                        check_horizontal(PrefixSum, Row, Col, N, GridSize)
                end;
            _ ->
                check_vertical(PrefixSum, Row, Col, N, GridSize)
        end
    end.

check_horizontal(PrefixSum, Row, Col, N, GridSize) ->
    lists:any(
        fun(Cut) ->
            Sum1 = maps:get({Row + Cut, Col}, PrefixSum),
            Sum2 = maps:get({GridSize - 1, Col}, PrefixSum) - Sum1,
            Sum1 == Sum2
        end,
        lists:seq(1, GridSize - 1)
    ).

check_vertical(PrefixSum, Row, Col, N, GridSize) ->
    lists:any(
        fun(Cut) ->
            Sum1 = maps:get({GridSize - 1, Col + Cut}, PrefixSum),
            Sum2 = maps:get({GridSize - 1, GridSize - 1}, PrefixSum) - Sum1,
            Sum1 == Sum2
        end,
        lists:seq(1, GridSize - 1)
    ).