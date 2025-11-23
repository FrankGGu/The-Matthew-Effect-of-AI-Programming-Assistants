-module(equal_sum_grid_partition_ii).
-export([equal_sum_grid_partition/1]).

equal_sum_grid_partition(Grid) ->
    N = length(Grid),
    {RowsSums, ColsSums} = calculate_sums(Grid, N),
    case find_partition(Grid, N, RowsSums, ColsSums) of
        true -> "Yes";
        false -> "No"
    end.

calculate_sums(Grid, N) ->
    RowsSums = lists:map(fun(Row) -> lists:sum(Row) end, Grid),
    ColsSums = calculate_col_sums(Grid, N, 0, []),
    {RowsSums, lists:reverse(ColsSums)}.

calculate_col_sums(Grid, N, ColIndex, Acc) when ColIndex == N ->
    Acc;
calculate_col_sums(Grid, N, ColIndex, Acc) ->
    ColSum = lists:sum([Grid !! RowIndex !! ColIndex || RowIndex <- lists:seq(1, N)]),
    calculate_col_sums(Grid, N, ColIndex + 1, [ColSum | Acc]).

find_partition(Grid, N, RowsSums, ColsSums) ->
    find_partition_helper(Grid, N, RowsSums, ColsSums, 1, 1, 0, 0, 0, 0).

find_partition_helper(_Grid, _N, _RowsSums, _ColsSums, Row, _Col, _SumA, _SumB, _SumC, _SumD) when Row > _N ->
    false;
find_partition_helper(_Grid, _N, _RowsSums, _ColsSums, _Row, Col, _SumA, _SumB, _SumC, _SumD) when Col > _N ->
    false;
find_partition_helper(Grid, N, RowsSums, ColsSums, Row, Col, SumA, SumB, SumC, SumD) ->
    Val = Grid !! Row !! Col,
    NewSumA = SumA + Val,

    case Row == N of
        true ->
            NewSumB = SumB + lists:sum(lists:sublist(ColsSums, 1, Col));
            NewSumC = SumC + lists:sum(lists:sublist(RowsSums, 1, Row));
            NewSumD = lists:sum(RowsSums) + lists:sum(ColsSums) - NewSumA - NewSumB - NewSumC;
            (NewSumA == NewSumB) and (NewSumA == NewSumC) and (NewSumA == NewSumD);
        false ->
            case Col == N of
                true ->
                    NewSumB = SumB + lists:sum(lists:sublist(ColsSums, 1, Col));
                    NewSumC = SumC + lists:sum(lists:sublist(RowsSums, 1, Row));
                    NewSumD = lists:sum(RowsSums) + lists:sum(ColsSums) - NewSumA - NewSumB - NewSumC;
                    (NewSumA == NewSumB) and (NewSumA == NewSumC) and (NewSumA == NewSumD);
                false ->
                    NewSumB = SumB + lists:sum(lists:sublist(ColsSums, 1, Col));
                    NewSumC = SumC + lists:sum(lists:sublist(RowsSums, 1, Row));
                    NewSumD = lists:sum(RowsSums) + lists:sum(ColsSums) - NewSumA - NewSumB - NewSumC;

                    (NewSumA == NewSumB) and (NewSumA == NewSumC) and (NewSumA == NewSumD) orelse
                    find_partition_helper(Grid, N, RowsSums, ColsSums, Row, Col + 1, NewSumA, SumB, SumC, SumD) orelse
                    find_partition_helper(Grid, N, RowsSums, ColsSums, Row + 1, 1, NewSumA, SumB, SumC, SumD)
            end
    end.