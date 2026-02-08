-module(minimum_path_sum).
-export([min_path_sum/1]).

min_path_sum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    DP1 = update_dp(Grid, Rows, Cols, DP),
    lists:nth(Rows, lists:nth(Cols, DP1)).

update_dp(Grid, Rows, Cols, DP) ->
    DP1 = update_dp_0_0(Grid, Rows, Cols, DP),
    update_dp_rest(Grid, Rows, Cols, DP1, 1, 1).

update_dp_0_0(Grid, Rows, Cols, DP) ->
    Value = lists:nth(1, lists:nth(1, Grid)),
    lists:nth(1, lists:nth(1, lists:update_element(1, DP, [Value | tl(lists:nth(1, DP))]))).

update_dp_rest(Grid, Rows, Cols, DP, Row, Col) ->
    if
        Row > Rows ->
            DP;
        true ->
            if
                Col > Cols ->
                    update_dp_rest(Grid, Rows, Cols, DP, Row + 1, 1);
                true ->
                    Value = lists:nth(Col, lists:nth(Row, Grid)),
                    PrevTop = get_prev_top(DP, Row, Col),
                    PrevLeft = get_prev_left(DP, Row, Col),
                    NewValue = Value + min(PrevTop, PrevLeft),
                    UpdatedRow = lists:nth(Row, lists:update_element(Col, DP, [NewValue | tl(lists:nth(Col, DP))])),
                    DP1 = lists:update_element(Row, DP, UpdatedRow),
                    update_dp_rest(Grid, Rows, Cols, DP1, Row, Col + 1)
            end
    end.

get_prev_top(DP, Row, Col) ->
    if
        Row == 1 ->
            infinity;
        true ->
            lists:nth(Col, lists:nth(Row - 1, DP))
    end.

get_prev_left(DP, Row, Col) ->
    if
        Col == 1 ->
            infinity;
        true ->
            lists:nth(Col - 1, lists:nth(Row, DP))
    end.