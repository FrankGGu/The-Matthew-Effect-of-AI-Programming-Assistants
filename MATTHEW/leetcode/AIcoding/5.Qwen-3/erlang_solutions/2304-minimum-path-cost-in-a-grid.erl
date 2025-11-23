-module(minimum_path_cost).
-export([minPathCost/2]).

minPathCost(Grid, MoveCost) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new(Rows, {default, array:new(Cols, {default, 0})}),
    init_dp(DP, Grid, 0, 0),
    lists:foreach(fun(Row) -> 
        lists:foreach(fun(Col) -> 
            if Row == 0 -> ok;
               true -> 
                   update_dp(DP, Grid, MoveCost, Row, Col)
            end
        end, lists:seq(0, Cols - 1))
    end, lists:seq(0, Rows - 1)),
    lists:min(array:to_list(array:get(Rows - 1, DP))).

init_dp(DP, Grid, Row, Col) ->
    case Row of
        0 -> array:set(Row, array:set(Col, hd(lists:nth(Row + 1, Grid)), array:get(Row, DP)), DP);
        _ -> DP
    end.

update_dp(DP, Grid, MoveCost, Row, Col) ->
    CurrentVal = array:get(Row, DP),
    CurrentValAtCol = array:get(Col, CurrentVal),
    PreviousRow = Row - 1,
    PreviousRowValues = array:get(PreviousRow, DP),
    MinPrevVal = lists:min(array:to_list(PreviousRowValues)),
    CostFromPrev = MinPrevVal + MoveCost[array:get(Col, array:get(PreviousRow, DP))][array:get(Col, array:get(Row, DP))],
    NewVal = CostFromPrev + array:get(Col, array:get(Row, DP)),
    array:set(Row, array:set(Col, NewVal, CurrentVal), DP).