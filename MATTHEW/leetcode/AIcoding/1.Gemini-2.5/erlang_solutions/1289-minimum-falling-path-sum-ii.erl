-module(solution).
-export([minFallingPathSum/1]).

minFallingPathSum(Grid) ->
    N = length(Grid),
    case N of
        1 ->
            hd(hd(Grid));
        _ ->
            % Initial DP state is the first row
            CurrentDP = hd(Grid),

            % Fold over the rest of the rows
            FinalDP = lists:foldl(
                fun(Row, AccDP) ->
                    % AccDP is the DP from the previous row
                    % Calculate Min1Val (smallest), Min1Idx (index of smallest), Min2Val (second smallest) from AccDP
                    {Min1Val, Min1Idx, Min2Val} = find_two_mins(AccDP),

                    % Build the new DP for the current row
                    % Iterate through Row with index
                    lists:map(
                        fun({Cost, ColIdx}) ->
                            PrevMin = if
                                          ColIdx == Min1Idx -> Min2Val;
                                          true -> Min1Val
                                      end,
                            Cost + PrevMin
                        end,
                        lists:zip(Row, lists:seq(0, N - 1))
                    )
                end,
                CurrentDP,
                tl(Grid)
            ),
            % After the fold, FinalDP is the DP list for the last row
            lists:min(FinalDP)
    end.

find_two_mins(List) ->
    % Initial state: {Min1Val, Min1Idx, Min2Val}
    find_two_mins(List, 0, {infinity, -1, infinity}).

find_two_mins([], _CurrentIdx, Acc) ->
    Acc;
find_two_mins([H|T], CurrentIdx, {M1, M1Idx, M2}) ->
    if
        H < M1 -> % New smallest value found
            find_two_mins(T, CurrentIdx + 1, {H, CurrentIdx, M1}); % Old M1 becomes M2
        H < M2 -> % New second smallest value found (H is between M1 and M2)
            find_two_mins(T, CurrentIdx + 1, {M1, M1Idx, H});
        true -> % H is not smaller than M1 or M2
            find_two_mins(T, CurrentIdx + 1, {M1, M1Idx, M2})
    end.