-module(solution).
-export([is_interleave/3]).

-include_lib("kernel/include/array.hrl").

is_interleave(S1, S2, S3) ->
    N1 = byte_size(S1),
    N2 = byte_size(S2),
    N3 = byte_size(S3),

    if N1 + N2 =/= N3 ->
        false;
    true ->
        % DP table: dp[i][j] means S3[0...i+j-1] can be formed by S1[0...i-1] and S2[0...j-1]
        % DP is an array of N1+1 arrays, where each inner array has N2+1 booleans.
        % Initialize all entries to false.
        InitialRow = array:new([{size, N2 + 1}, {fixed, true}, {default, false}]),
        DP = array:new([{size, N1 + 1}, {fixed, true}, {default, InitialRow}]),

        % Base case: dp[0][0] = true (empty strings interleave to an empty string)
        % Get the first row (index 0), set its first element (index 0) to true,
        % then update the main DP array with this modified row.
        DP1 = array:set(0, array:set(0, true, array:get(0, DP)), DP),

        % Fill the first row (when S1 is empty)
        % dp[0][j] = dp[0][j-1] and S2[j-1] == S3[j-1]
        DP2 = lists:foldl(fun(J, CurrentDP) ->
            PrevRow0 = array:get(0, CurrentDP), % Get the current state of row 0
            PrevVal = array:get(J-1, PrevRow0),
            S2_char = binary:at(S2, J-1), % 0-indexed character from S2
            S3_char = binary:at(S3, J-1), % 0-indexed character from S3
            if PrevVal andalso S2_char == S3_char ->
                % Update row 0 at index J, then update the main DP array
                array:set(0, array:set(J, true, PrevRow0), CurrentDP);
            true ->
                CurrentDP
            end
        end, DP1, lists:seq(1, N2)),

        % Fill the first column (when S2 is empty)
        % dp[i][0] = dp[i-1][0] and S1[i-1] == S3[i-1]
        DP3 = lists:foldl(fun(I, CurrentDP) ->
            PrevColVal = array:get(0, array:get(I-1, CurrentDP)), % Value from dp[i-1][0]
            S1_char = binary:at(S1, I-1), % 0-indexed character from S1
            S3_char = binary:at(S3, I-1), % 0-indexed character from S3
            if PrevColVal andalso S1_char == S3_char ->
                Row_I = array:get(I, CurrentDP), % Get the current row I (initially all false)
                % Update row I at index 0, then update the main DP array
                array:set(I, array:set(0, true, Row_I), CurrentDP);
            true ->
                CurrentDP
            end
        end, DP2, lists:seq(1, N1)),

        % Fill the rest of the DP table
        FinalDP = lists:foldl(fun(I, CurrentDP_I) ->
            % Row_I is the current row we are building (array for dp[I][0...N2])
            % It already has dp[I][0] correctly set from the previous step.
            Row_I = array:get(I, CurrentDP_I),
            % PrevRow_I is the fully computed previous row (array for dp[I-1][0...N2])
            PrevRow_I = array:get(I-1, CurrentDP_I),

            NewRow_I = lists:foldl(fun(J, AccRow) ->
                Val1 = false, % Corresponds to dp[i-1][j]
                Val2 = false, % Corresponds to dp[i][j-1]

                % Check if S3[I+J-1] matches S1[I-1] and dp[I-1][J] is true
                if binary:at(S1, I-1) == binary:at(S3, I+J-1) ->
                    if array:get(J, PrevRow_I) ->
                        Val1 = true;
                    true ->
                        ok
                    end;
                true ->
                    ok
                end,

                % Check if S3[I+J-1] matches S2[J-1] and dp[I][J-1] is true
                if binary:at(S2, J-1) == binary:at(S3, I+J-1) ->
                    % AccRow holds the values for the current row I being built,
                    % so array:get(J-1, AccRow) gives dp[I][J-1]
                    if array:get(J-1, AccRow) ->
                        Val2 = true;
                    true ->
                        ok
                    end;
                true ->
                    ok
                end,

                if Val1 orelse Val2 ->
                    array:set(J, true, AccRow);
                true ->
                    AccRow
                end
            end, Row_I, lists:seq(1, N2)), % Start with Row_I which has dp[I][0]

            % Update the main DP array with the newly computed row I
            array:set(I, NewRow_I, CurrentDP_I)
        end, DP3, lists:seq(1, N1)),

        % The final result is dp[N1][N2]
        array:get(N2, array:get(N1, FinalDP))
    end.