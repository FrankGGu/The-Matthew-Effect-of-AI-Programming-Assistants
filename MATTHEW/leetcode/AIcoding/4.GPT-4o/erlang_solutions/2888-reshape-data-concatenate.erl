-module(solution).
-export([reshape/2]).

reshape(Matrix, r) ->
    Rows = lists:length(Matrix),
    Columns = lists:length(hd(Matrix)),
    Total = Rows * Columns,
    NewCol = r,
    NewRow = div(Total, NewCol),
    Reshaped = reshape_helper(Matrix, NewRow, NewCol, [], 0, 0),
    lists:sublist(Reshaped, 0, NewRow).

reshape_helper(_, 0, _, Acc, _, _) -> Acc;
reshape_helper([], _, _, Acc, _, _) -> Acc;
reshape_helper(Matrix, NewRow, NewCol, Acc, CurrentRow, CurrentCol) ->
    case CurrentCol of
        NewCol -> reshape_helper(Matrix, NewRow, NewCol, Acc ++ [[]], CurrentRow + 1, 0);
        _ -> 
            case lists:nth(CurrentRow + 1, Matrix) of
                [] -> Acc;
                Row ->
                    NewValue = lists:nth(CurrentCol + 1, Row),
                    NewAcc = lists:update_at(CurrentRow + 1, fun(X) -> X ++ [NewValue] end, Acc),
                    reshape_helper(Matrix, NewRow, NewCol, NewAcc, CurrentRow, CurrentCol + 1)
            end
    end.