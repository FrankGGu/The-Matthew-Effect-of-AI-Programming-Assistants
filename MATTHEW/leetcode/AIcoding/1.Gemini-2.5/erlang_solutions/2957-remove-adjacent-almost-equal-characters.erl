-module(solution).
-export([min_adjacent_almost_equal_characters/1]).

min_adjacent_almost_equal_characters(S) ->
    N = length(S),

    % dp[i][j] = minimum removals for s[0...i] such that s[i] is kept and its character value is j.
    % We use a tuple of lists for the DP table. Each inner list is a row for dp[i].
    % Initialize with a large number (infinity).
    Inf = 1000000000, 

    % Initial DP table: a tuple of N lists, each list containing 26 'Inf' values.
    InitialDPTable = list_to_tuple(lists:duplicate(N, lists:duplicate(26, Inf))),

    % Fold over the characters of the string with their 0-based index.
    % The accumulator is a tuple {Idx, CurrentDPTable}.
    {_, FinalDPTable} = lists:foldl(
        fun(Char, {Idx, CurrentDPTable}) ->
            process_char_with_dp_table(Char, Idx, CurrentDPTable, Inf)
        end, {0, InitialDPTable}, S),

    % The result is the minimum value in the last row of the DP table (dp[N-1]).
    LastRow = element(N, FinalDPTable), % Nth element (1-indexed) corresponds to dp[N-1]
    lists:min(LastRow).

process_char_with_dp_table(Char, Idx, CurrentDPTable, Inf) ->
    CharIdx = Char - $a, % 0-indexed character code for the current character

    % Get the current row (which we are building for dp[Idx]) and the previous row (dp[Idx-1]).
    % CurrentRow is initially a list of Inf values from CurrentDPTable.
    CurrentRow = element(Idx + 1, CurrentDPTable), 
    PrevRow = if Idx > 0 -> element(Idx, CurrentDPTable);
                true -> lists:duplicate(26, Inf) % Dummy row for Idx=0, not used for actual prev_cost
             end,

    % --- Option 1: Keep the current character (Char) ---
    % Calculate the minimum cost from previous states if Char is kept.
    MinPrevKeptCost = if Idx == 0 ->
                            0; % If it's the first character, no previous cost.
                         true ->
                            % Iterate through all possible previous character indices (K).
                            % Find the minimum cost from dp[Idx-1][K] such that Char and K are NOT almost-equal.
                            lists:foldl(fun(K, AccMin) ->
                                            if abs(CharIdx - K) > 1 -> % Check if Char and K are NOT almost-equal
                                                min(AccMin, lists:nth(K + 1, PrevRow)); % lists:nth is 1-indexed
                                            true ->
                                                AccMin
                                            end
                                        end, Inf, lists:seq(0, 25))
                      end,

    % Update the CurrentRow at CharIdx with MinPrevKeptCost if it's a valid path.
    NewCurrentRow = if MinPrevKeptCost /= Inf -> % If it's possible to keep Char
                        setelement(CharIdx + 1, CurrentRow, MinPrevKeptCost); % setelement is 1-indexed
                    true ->
                        CurrentRow % CharIdx position remains Inf if not possible to keep
                    end,

    % --- Option 2: Remove the current character (Char) ---
    % If Char is removed, the last kept character is from the previous step (dp[Idx-1][J]).
    % The cost for dp[Idx][J] (where J is the last kept char) is dp[Idx-1][J] + 1.
    % We combine this with the values already in NewCurrentRow (from Option 1).
    FinalCurrentRow = lists:map_indexed(fun(Val, J) ->
                                                if J == CharIdx ->
                                                    Val; % Value for CharIdx already set by Option 1
                                                Idx == 0 -> % If first char, and removed, cost is 1 for other J
                                                    min(Val, 1);
                                                true ->
                                                    % dp[Idx][J] = min(current_val_at_J, dp[Idx-1][J] + 1)
                                                    min(Val, lists:nth(J + 1, PrevRow) + 1)
                                                end
                                        end, NewCurrentRow),

    % Update the DP table (tuple) with the newly computed row for dp[Idx].
    UpdatedDPTable = setelement(Idx + 1, CurrentDPTable, FinalCurrentRow),

    % Return the next index and the updated DP table.
    {Idx + 1, UpdatedDPTable}.

lists:map_indexed(F, L) ->
    lists:map_indexed(F, L, 0).

lists:map_indexed(F, [H|T], Idx) ->
    [F(H, Idx) | lists:map_indexed(F, T, Idx + 1)];
lists:map_indexed(_F, [], _Idx) ->
    [].