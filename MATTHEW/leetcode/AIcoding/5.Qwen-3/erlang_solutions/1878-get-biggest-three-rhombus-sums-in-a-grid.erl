-module(solution).
-export([get_rhombus_sums/1]).

get_rhombus_sums(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxSize = min(Rows, Cols),
    Sums = lists:foldl(fun(Size, Acc) -> 
        get_sums_for_size(Grid, Size, Acc)
    end, [], lists:seq(1, MaxSize)),
    lists:usort(lists:flatten(Sums)) -- [0],
    case lists:reverse(lists:usort(lists:flatten(Sums))) of
        [] -> [];
        L -> lists:sublist(L, 3)
    end.

get_sums_for_size(_, 0, Acc) -> Acc;
get_sums_for_size(Grid, Size, Acc) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    SumList = [],
    RowIndices = lists:seq(0, Rows - 1),
    ColIndices = lists:seq(0, Cols - 1),
    lists:foldl(fun(Row, Acc2) ->
        lists:foldl(fun(Col, Acc3) ->
            if
                is_valid_position(Row, Col, Size, Rows, Cols) ->
                    Sum = calculate_rhombus_sum(Grid, Row, Col, Size),
                    [Sum | Acc3];
                true ->
                    Acc3
            end
        end, Acc2, ColIndices)
    end, SumList, RowIndices).

is_valid_position(Row, Col, Size, Rows, Cols) ->
    (Row + Size - 1 < Rows) and (Col + Size - 1 < Cols) and (Row - Size + 1 >= 0) and (Col - Size + 1 >= 0).

calculate_rhombus_sum(Grid, Row, Col, Size) ->
    Total = 0,
    Side = Size - 1,
    calculate_rhombus_sum_helper(Grid, Row, Col, Size, Side, Total).

calculate_rhombus_sum_helper(_, _, _, 0, _, Total) -> Total;
calculate_rhombus_sum_helper(Grid, Row, Col, Size, Side, Total) ->
    NewTotal = add_points(Grid, Row, Col, Side, Total),
    calculate_rhombus_sum_helper(Grid, Row, Col, Size - 1, Side - 1, NewTotal).

add_points(Grid, Row, Col, Side, Total) ->
    lists:foldl(fun(I, Acc) ->
        R1 = Row - Side + I,
        C1 = Col - Side + I,
        R2 = Row + Side - I,
        C2 = Col + Side - I,
        R3 = Row + Side - I,
        C3 = Col - Side + I,
        R4 = Row - Side + I,
        C4 = Col + Side - I,
        Value1 = element(C1 + 1, element(R1 + 1, Grid)),
        Value2 = element(C2 + 1, element(R2 + 1, Grid)),
        Value3 = element(C3 + 1, element(R3 + 1, Grid)),
        Value4 = element(C4 + 1, element(R4 + 1, Grid)),
        Acc + Value1 + Value2 + Value3 + Value4
    end, Total, lists:seq(0, Side)).