-module(solution).
-export([numMusicPlaylists/3]).

numMusicPlaylists(N, Goal, K) ->
    Mod = 1_000_000_007,

    % dp_table[i][j] represents the number of playlists of length i using j unique songs.
    % It will be an array of arrays, where dp_table[i] is an array representing the i-th row.

    % Base case: dp[0][0] = 1 (empty playlist, 0 unique songs)
    % Create Row0: an array of size (N + 1) initialized with zeros, then set dp[0][0] to 1.
    Row0 = array:set(0, 1, array:new([{size, N + 1}, {fixed, true}, {default, 0}])),

    % Initialize the main dp_table with Row0 at index 0.
    % Other rows will be filled in the loop.
    DP_Table_Initial = array:set(0, Row0, array:new([{size, Goal + 1}, {fixed, true}]) ),

    % Iterate for I from 1 to Goal (playlist length)
    FinalDP_Table = lists:foldl(fun(I, CurrentDP_Table) ->
        % Get the previous row (I-1) from the DP_Table
        PrevRow = array:get(I - 1, CurrentDP_Table),

        % Create the current row (I) as an array of size (N + 1) initialized with zeros.
        % dp[I][0] will remain 0 for I > 0.
        CurrentRow = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

        % Iterate for J from 1 to N (number of unique songs)
        % If J > I, dp[I][J] will naturally be 0 because dp[I-1][J-1] and dp[I-1][J] would be 0.
        NewCurrentRow = lists:foldl(fun(J, AccRow) ->
            % Calculate dp[I][J] based on previous row values

            % Term 1: Add a new song
            % This requires J-1 unique songs in the playlist of length I-1.
            % There are (N - (J - 1)) new songs available to choose from.
            DP_Prev_J_Minus_1 = array:get(J - 1, PrevRow),
            Term1 = (DP_Prev_J_Minus_1 * (N - (J - 1))) rem Mod,

            % Term 2: Add an existing song
            % This requires J unique songs in the playlist of length I-1.
            % Due to the 'K' constraint, only max(0, J - K) songs can be replayed.
            DP_Prev_J = array:get(J, PrevRow),
            Term2 = (DP_Prev_J * max(0, J - K)) rem Mod,

            % Sum the two terms and apply modulo
            NewVal = (Term1 + Term2) rem Mod,

            % Set dp[I][J] in the current row
            array:set(J, NewVal, AccRow)
        end, CurrentRow, lists:seq(1, N)), % J ranges from 1 to N

        % Set the fully computed CurrentRow into the main DP_Table at index I
        array:set(I, NewCurrentRow, CurrentDP_Table)
    end, DP_Table_Initial, lists:seq(1, Goal)),

    % The final answer is dp[Goal][N]
    % Get the Goal-th row from the final DP_Table
    GoalRow = array:get(Goal, FinalDP_Table),
    % Get the N-th element from the Goal-th row
    array:get(N, GoalRow).