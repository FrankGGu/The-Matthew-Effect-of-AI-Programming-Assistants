-module(solution).
-export([minOperations/1]).

is_strictly_less(Row1, Row2) ->
    lists:all(fun({X, Y}) -> X < Y end, lists:zip(Row1, Row2)).

minOperations(Grid) ->
    M = length(Grid),
    case M of
        0 -> 0;
        1 -> 0;
        _ ->
            % Convert Grid to an array for O(1) row access
            GridArray = array:from_list(Grid),

            % dp[i] stores the length of the longest strictly increasing subsequence ending at row i.
            % Initialize dp array with all 1s.
            DP = array:new([{size, M}, {fixed, true}, {default, 1}]),

            % Iterate through each row i from 0 to M-1
            FinalDP = lists:foldl(
                fun(I, CurrentDP) ->
                    RowI = array:get(I, GridArray),

                    % Find the maximum length of a previous strictly increasing subsequence
                    % that can be extended by RowI.
                    MaxPrevLen = lists:foldl(
                        fun(J, AccMax) ->
                            RowJ = array:get(J, GridArray),
                            if
                                is_strictly_less(RowJ, RowI) ->
                                    max(AccMax, array:get(J, CurrentDP));
                                true ->
                                    AccMax
                            end
                        end,
                        0, % Initial max length from previous rows is 0
                        lists:seq(0, I - 1) % Iterate through previous rows j < i
                    ),

                    % Update dp[I] with 1 + MaxPrevLen
                    array:set(I, 1 + MaxPrevLen, CurrentDP)
                end,
                DP,
                lists:seq(0, M - 1)
            ),

            % The maximum value in the DP array is the maximum number of rows we can keep.
            FinalDPList = array:to_list(FinalDP),
            MaxKeptRows = lists:max(FinalDPList),

            % The minimum operations is total rows minus max kept rows.
            M - MaxKeptRows
    end.