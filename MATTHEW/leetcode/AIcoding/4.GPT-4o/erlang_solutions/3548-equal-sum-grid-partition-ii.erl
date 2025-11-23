-module(solution).
-export([equal_sum_partition/1]).

equal_sum_partition(Grid) ->
    N = length(Grid),
    S = lists:sum(lists:map(fun(Row) -> lists:sum(Row) end, Grid)),
    if S rem 2 =:= 0 -> 
        Target = S div 2,
        can_partition(Grid, N, Target, 0)
    end.

can_partition(_, 0, 0) -> true;
can_partition(Grid, N, Target, Index) ->
    Row = lists:nth(Index + 1, Grid),
    SumRow = lists:sum(Row),
    if 
        SumRow > Target -> can_partition(Grid, N, Target, Index + 1);
        can_partition(Grid, N, Target - SumRow, Index + 1) orelse can_partition(Grid, N, Target, Index + 1)
    end.