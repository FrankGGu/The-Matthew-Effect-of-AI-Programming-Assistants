-module(solution).
-export([minimum_total/1]).

minimum_total([FirstRow | RestOfTriangle]) ->
    min_path_sum_acc(RestOfTriangle, FirstRow).

min_path_sum_acc([], CurrentDPRow) ->
    lists:min(CurrentDPRow);
min_path_sum_acc([CurrentRow | RemainingRows], PrevDPRow) ->
    NewDPRow = calculate_dp_row(CurrentRow, PrevDPRow),
    min_path_sum_acc(RemainingRows, NewDPRow).

calculate_dp_row([C1 | CTail], [P1 | PTail]) ->
    [C1 + P1 | calculate_dp_row_tail(CTail, [P1 | PTail])].

calculate_dp_row_tail([C_i | CTail], [P_left | [P_right | PTail]]) ->
    [C_i + min(P_left, P_right) | calculate_dp_row_tail(CTail, [P_right | PTail])];
calculate_dp_row_tail([C_last], [P_last]) ->
    [C_last + P_last].