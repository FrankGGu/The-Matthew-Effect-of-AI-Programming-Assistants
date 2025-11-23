-module(solution).
-export([max_increase_keeping_skyline/1]).

max_increase_keeping_skyline(City) ->
    Rows = length(City),
    Cols = length(hd(City)),
    MaxRows = lists:map(fun(Row) -> lists:max(Row) end, City),
    MaxCols = lists:map(fun(Col) -> lists:max(lists:map(fun(Row) -> lists:nth(Col + 1, Row) end, City)) end, lists:seq(0, Cols - 1)),
    TotalIncrease = lists:foldl(fun({Row, Col}, Acc) -> 
        Acc + (min(lists:nth(Row + 1, MaxRows), lists:nth(Col + 1, MaxCols)) - lists:nth(Col + 1, lists:nth(Row + 1, City))) 
    end, 0, lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Col, Acc1) -> [{Row, Col} | Acc1] end, Acc, lists:seq(0, Cols - 1))
    end, [], lists:seq(0, Rows - 1)),
    TotalIncrease.