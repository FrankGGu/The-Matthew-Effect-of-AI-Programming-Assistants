-module(solution).
-export([shortest_supersequence_frequencies/2]).

shortest_supersequence_frequencies(Str1, Str2) ->
    % Convert binaries to arrays of characters for O(1) access.
    % binary:at(Bin, Pos) is 0-indexed.
    % We will use 0-indexed access for characters.
    S1_arr = array:from_list(binary_to_list(Str1)),
    S2_arr = array:from_list(binary_to_list(Str2)),
    M = byte_size(Str1),
    N = byte_size(Str2),

    % DP table: array of arrays. Each element is {Length, Count}.
    % dp[i][j] stores the result for S1[0...i-1] and S2[0...j-1].
    % Indices I and J correspond to lengths of prefixes.
    % So dp[I][J] is for S1's prefix of length I and S2's prefix of length J.
    % The DP table will have dimensions (M+1) x (N+1).

    % Initialize the first row (I=0).
    % For S1's prefix of length 0 (empty string), SCS with S2's prefix of length J
    % is S2's prefix itself. Length J, Count 1.
    Row0_elements = lists:map(fun(J) -> {J, 1} end, lists:seq(0, N)),
    Row0 = array:from_list(Row0_elements),

    % Initialize the DP table as an array of arrays.
    % It starts with Row0 at index 0.
    % array:new(M+1, {default, ...}) creates an array of M+1 elements,
    % where each element is initialized to the default value.
    % The default value here is an array of N+1 {0,0} tuples.
    InitialDP_Rows = array:set(0, Row0, array:new(M+1, {default, array:new(N+1, {default, {0,0}})})),

    % Fold through rows from I=1 to M.
    FinalDP_Rows = lists:foldl(fun(I, AccDP_Rows) ->
        PrevRow = array:get(I-1, AccDP_Rows), % This is dp[I-1] (the previous row)

        % Initialize CurrentRow (dp[I]) for the current I.
        % Base case for J=0: SCS of S1[0...I-1] and "" is S1[0...I-1]. Length I, Count 1.
        CurrentRow = array:set(0, {I, 1}, array:new(N+1, {default, {0,0}})),

        % Fold through columns from J=1 to N to build the rest of CurrentRow.
        NewCurrentRow = lists:foldl(fun(J, AccCurrentRow) ->
            % Characters are at (I-1) and (J-1) in the original strings due to 0-indexing.
            Char1 = array:get(I-1, S1_arr),
            Char2 = array:get(J-1, S2_arr),

            % Get values from previous states:
            % dp[I-1][J]
            {PrevLen_i_minus_1_j, PrevCount_i_minus_1_j} = array:get(J, PrevRow),

            % dp[I][J-1]
            {PrevLen_i_j_minus_1, PrevCount_i_j_minus_1} = array:get(J-1, AccCurrentRow),

            % dp[I-1][J-1]
            {PrevLen_i_minus_1_j_minus_1, PrevCount_i_minus_1_j_minus_1} = array:get(J-1, PrevRow),

            NewLen = 0,
            NewCount = 0,

            if Char1 == Char2 ->
                % If characters match, we include this character once.
                % The SCS length is 1 + SCS of prefixes excluding these characters.
                NewLen = 1 + PrevLen_i_minus_1_j_minus_1,
                NewCount = PrevCount_i_minus_1_j_minus_1;
            true ->
                % If characters don't match, we consider two options:
                % 1. Include Char1, then find SCS of S1[0...I-2] and S2[0...J-1].
                Len1 = 1 + PrevLen_i_minus_1_j,
                Count1 = PrevCount_i_minus_1_j,

                % 2. Include Char2, then find SCS of S1[0...I-1] and S2[0...J-2].
                Len2 = 1 + PrevLen_i_j_minus_1,
                Count2 = PrevCount_i_j_minus_1,

                if Len1 < Len2 ->
                    NewLen = Len1,
                    NewCount = Count1;
                Len2 < Len1 ->
                    NewLen = Len2,
                    NewCount = Count2;
                true -> % Len1 == Len2
                    NewLen = Len1,
                    NewCount = Count1 + Count2
                end
            end,
            % Update the current row with the calculated {NewLen, NewCount} at index J.
            array:set(J, {NewLen, NewCount}, AccCurrentRow)
        end, CurrentRow, lists:seq(1, N)),
        % Add the newly completed row to the array of DP rows.
        array:set(I, NewCurrentRow, AccDP_Rows)
    end, InitialDP_Rows, lists:seq(1, M)),

    % The final result is in dp[M][N].
    {_Length, Count} = array:get(N, array:get(M, FinalDP_Rows)),
    Count.