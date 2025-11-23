-module(solution).
-export([get_biggest_three/1]).

get_biggest_three(Grid) ->
    MaxRows = length(Grid),
    MaxCols = length(hd(Grid)),
    RhombusSums = sets:new(),
    lists:foreach(fun(Row) ->
        lists:foreach(fun(Col) ->
            MaxSize = min(min(Row, Col), min(MaxRows - 1 - Row, MaxCols - 1 - Col)),
            lists:foreach(fun(Size) ->
                Sum = calculate_rhombus_sum(Grid, Row, Col, Size),
                sets:add(Sum, RhombusSums)
            end, lists:seq(0, MaxSize))
        end, lists:seq(0, MaxCols - 1))
    end, lists:seq(0, MaxRows - 1)),
    SortedSums = sets:to_list(RhombusSums),
    lists:reverse(lists:sort(SortedSums)),
    lists:sublist(SortedSums, 3).

calculate_rhombus_sum(Grid, Row, Col, Size) ->
    Sum = lists:foldl(fun(Idx, Acc) ->
        Up = lists:nth(Row - Idx + 1, Grid),
        Down = lists:nth(Row + Idx + 1, Grid),
        Acc + lists:nth(Col - Idx + 1, Up) + lists:nth(Col + Idx + 1, Up) + 
        lists:nth(Col - Idx + 1, Down) + lists:nth(Col + Idx + 1, Down)
    end, lists:nth(Row + 1, Grid), lists:seq(0, Size)),
    Sum - lists:nth(Row + 1, Grid).