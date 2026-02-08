-module(solution).
-export([maxPoints/1]).

maxPoints(Points) ->
    M = length(Points),
    N = length(hd(Points)),
    InitialDP = hd(Points),
    RowsToProcess = tl(Points),
    FinalDP = lists:foldl(
        fun(CurrentPointsRow, PrevDP) ->
            Left = calculate_left(PrevDP),
            Right = calculate_right(PrevDP),
            calculate_current_dp_row(CurrentPointsRow, Left, Right, 0, [])
        end, InitialDP, RowsToProcess),
    lists:max(FinalDP).

calculate_left(PrevDP) ->
    % A sufficiently small number for negative infinity.
    % Max possible score is 10^5 * 10^5 = 10^10.
    % Min possible score is 0 - 10^5 * 10^5 = -10^10.
    % -10^15 is a safe lower bound.
    calculate_left_acc(PrevDP, 0, -10000000000000000, []).

calculate_left_acc([], _, _, Acc) ->
    lists:reverse(Acc);
calculate_left_acc([H_PrevDP|T_PrevDP], J, MaxValSoFar, Acc) ->
    CurrentMax = max(MaxValSoFar, H_PrevDP - J),
    calculate_left_acc(T_PrevDP, J+1, CurrentMax, [CurrentMax|Acc]).

calculate_right(PrevDP) ->
    calculate_right_acc(lists:reverse(PrevDP), length(PrevDP)-1, -10000000000000000, []).

calculate_right_acc([], _, _, Acc) ->
    Acc;
calculate_right_acc([H_PrevDP|T_PrevDP], J, MaxValSoFar, Acc) ->
    CurrentMax = max(MaxValSoFar, H_PrevDP + J),
    calculate_right_acc(T_PrevDP, J-1, CurrentMax, [CurrentMax|Acc]).

calculate_current_dp_row([], [], [], _, Acc) ->
    lists:reverse(Acc);
calculate_current_dp_row([H_Points|T_Points], [H_Left|T_Left], [H_Right|T_Right], J, Acc) ->
    Val = H_Points + max(H_Left + J, H_Right - J),
    calculate_current_dp_row(T_Points, T_Left, T_Right, J+1, [Val|Acc]).