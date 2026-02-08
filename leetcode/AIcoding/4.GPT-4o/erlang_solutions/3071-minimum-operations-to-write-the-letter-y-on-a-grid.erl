-module(solution).
-export([min_operations/2]).

min_operations(Grid, Target) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MinOps = lists:foldl(fun({Row, Col}, Acc) ->
        Ops = calculate_operations(Grid, Row, Col, Target),
        min(Ops, Acc)
    end, infinity, [{R, C} || R <- lists:seq(1, Rows), C <- lists:seq(1, Cols)]),
    MinOps.

calculate_operations(Grid, Row, Col, Target) ->
    TargetList = string:to_list(Target),
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    lists:foldl(fun({R, C}, Acc) ->
        case lists:nth(C, lists:nth(R, Grid)) of
            Char when Char == lists:nth(C, TargetList) -> Acc;
            _ -> Acc + 1
        end
    end, 0, [{R, C} || R <- lists:seq(1, Rows), C <- lists:seq(1, Cols)]).