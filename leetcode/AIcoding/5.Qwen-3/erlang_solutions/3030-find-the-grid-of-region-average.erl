-module(solution).
-export([avg_of_region/1]).

avg_of_region(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Grid)),
            Result = lists:seq(0, Rows-1),
            lists:map(fun(Row) ->
                lists:map(fun(Col) ->
                    get_avg(Grid, Row, Col, Rows, Cols)
                end, lists:seq(0, Cols-1))
            end, Result)
    end.

get_avg(Grid, Row, Col, Rows, Cols) ->
    Sum = 0,
    Count = 0,
    lists:foldl(fun(R, AccSum) ->
        lists:foldl(fun(C, {Sum, Count}) ->
            case (R >= 0) and (R < Rows) and (C >= 0) and (C < Cols) of
                true ->
                    {Sum + element(C+1, element(R+1, Grid)), Count + 1};
                false ->
                    {Sum, Count}
            end
        end, {AccSum, 0}, lists:seq(max(0, Col-1), min(Cols-1, Col+1)))
    end, {0, 0}, lists:seq(max(0, Row-1), min(Rows-1, Row+1))),
    {Sum, Count} = lists:foldl(fun(R, Acc) ->
        lists:foldl(fun(C, {S, Cnt}) ->
            case (R >= 0) and (R < Rows) and (C >= 0) and (C < Cols) of
                true ->
                    {S + element(C+1, element(R+1, Grid)), Cnt + 1};
                false ->
                    {S, Cnt}
            end
        end, Acc, lists:seq(max(0, Col-1), min(Cols-1, Col+1)))
    end, {0, 0}, lists:seq(max(0, Row-1), min(Rows-1, Row+1))),
    trunc(Sum / Count).