-module(solution).
-export([minPathSum/1]).

minPathSum(Grid) ->
    M = length(Grid),
    case M of
        0 -> 0; % Empty grid
        _ ->
            N = length(hd(Grid)),
            case N of
                0 -> 0; % Empty grid rows
                _ ->
                    % Calculate the first DP row
                    FirstGridRow = hd(Grid),
                    DPFirstRow = calculate_first_dp_row(FirstGridRow),

                    % Fold over the rest of the grid rows to calculate subsequent DP rows
                    % The accumulator is the previously calculated DP row
                    LastDPRow = lists:foldl(fun(CurrentGridRow, PrevDPRow) ->
                                                calculate_dp_row(CurrentGridRow, PrevDPRow)
                                            end, DPFirstRow, tl(Grid)),

                    % The minimum path sum is the last element of the last DP row
                    lists:last(LastDPRow)
            end
    end.

calculate_first_dp_row(GridRow) ->
    lists:reverse(lists:foldl(fun(Val, Acc) ->
                                  case Acc of
                                      [] -> [Val];
                                      [H | _] -> [Val + H | Acc]
                                  end
                              end, [], GridRow)).

calculate_dp_row(CurrentGridRow, PrevDPRow) ->
    % DP_i0 = G_i0 + DP_(i-1)0
    DP_i0 = hd(CurrentGridRow) + hd(PrevDPRow),

    % Fold over the rest of the elements (from index 1 to N-1)
    % Acc: {ReversedCurrentDPRow, LastDPValInCurrentRow}
    % Initial Acc: {[DP_i0], DP_i0}
    % Iteration elements: {GridVal_j, PrevDPVal_j} for j from 1 to N-1
    {ReversedDPRow, _} = lists:foldl(fun({GridVal, PrevDPVal}, {AccDPRow, LastDPValInCurrentRow}) ->
                                       CurrentDPVal = GridVal + min(PrevDPVal, LastDPValInCurrentRow),
                                       {[CurrentDPVal | AccDPRow], CurrentDPVal}
                                   end, {[DP_i0], DP_i0}, lists:zip(tl(CurrentGridRow), tl(PrevDPRow))),

    lists:reverse(ReversedDPRow).