-module(solution).
-export([minFlips/1]).

minFlips(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    calculate_flips(Grid, M, N, 0, 0, 0).

calculate_flips(Grid, M, N, I, J, TotalFlips) when I < (M + 1) div 2 ->
    NewTotalFlips = calculate_flips_row(Grid, M, N, I, J, TotalFlips),
    calculate_flips(Grid, M, N, I + 1, 0, NewTotalFlips);
calculate_flips(_Grid, _M, _N, _I, _J, TotalFlips) ->
    TotalFlips.

calculate_flips_row(Grid, M, N, I, J, CurrentFlips) when J < (N + 1) div 2 ->
    % Collect values for the symmetric group
    Vals = [get_value(Grid, I, J)],

    Vals2 = if J =/= N - 1 - J ->
                [get_value(Grid, I, N - 1 - J) | Vals]
            else
                Vals
            end,

    Vals3 = if I =/= M - 1 - I ->
                [get_value(Grid, M - 1 - I, J) | Vals2]
            else
                Vals2
            end,

    AllVals = if I =/= M - 1 - I and J =/= N - 1 - J ->
                  [get_value(Grid, M - 1 - I, N - 1 - J) | Vals3]
              else
                  Vals3
              end,

    % Count 0s and 1s
    {NumZeros, NumOnes} = lists:foldl(fun(Val, {Z, O}) ->
                                            if Val == 0 -> {Z + 1, O};
                                               Val == 1 -> {Z, O + 1}
                                            end
                                    end, {0, 0}, AllVals),

    FlipsForGroup = min(NumZeros, NumOnes),

    calculate_flips_row(Grid, M, N, I, J + 1, CurrentFlips + FlipsForGroup);
calculate_flips_row(_Grid, _M, _N, _I, _J, CurrentFlips) ->
    CurrentFlips.

get_value(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).