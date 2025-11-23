-module(solution).
-export([numWays/2]).

numWays(Words, Target) ->
    MOD = 1000000007,
    TargetLen = length(Target),
    WordLen = length(hd(Words)),

    % Precompute character counts for each column
    % Counts is a 0-indexed list of maps, where each map stores character counts for a specific column.
    % e.g., Counts = [#{'a' => 1, 'b' => 1}, #{'c' => 2}, ...]
    Counts = precompute_counts(Words, WordLen),

    % dp_prev_array corresponds to dp[i] (0-indexed target char index)
    % dp_curr_array corresponds to dp[i+1]

    % Initial dp_prev_array (for i=0, empty target prefix)
    % All values are 1, representing dp[0][0]..dp[0][WordLen]
    % array:new(Size, {default, Value}) creates an array of Size with all elements initialized to Value.
    DpPrevArray = array:new(WordLen + 1, {default, 1}),

    % Iterate for target character index `I` from 0 to TargetLen - 1.
    % In each iteration, we compute dp[I+1] (DpCurrentArray) based on dp[I] (AccDpPrevArray).
    FinalDpArray = lists:foldl(
        fun(I, AccDpPrevArray) -> % AccDpPrevArray holds dp[I]
            % Get the character target[I] (1-indexed access for Erlang lists)
            TargetChar = lists:nth(I + 1, Target), 

            % Initialize DpCurrentArray for dp[I+1].
            % dp[I+1][0] is 0 (cannot form a non-empty target prefix with 0 columns).
            % Other elements are initialized to 0 and will be updated.
            DpCurrentArray = array:set(0, 0, array:new(WordLen + 1, {default, 0})),

            % Iterate for column count `J` from 1 to WordLen.
            % This `J` corresponds to using column index `J-1` from dictionary words.
            lists:foldl(
                fun(J, AccDpCurrentArray) -> % AccDpCurrentArray is the partially built dp[I+1]
                    % Val1 = dp[I+1][J-1] (ways to form target[0...I] without using column J-1)
                    Val1 = array:get(J - 1, AccDpCurrentArray), 

                    % PrevPrevDpVal = dp[I][J-1] (ways to form target[0...I-1] using columns 0...J-2)
                    PrevPrevDpVal = array:get(J - 1, AccDpPrevArray),

                    % ColumnCounts is the map for column J-1 (1-indexed access for Counts list)
                    ColumnCounts = lists:nth(J, Counts), 
                    % Get count of TargetChar in column J-1, default to 0 if not present
                    CharCount = maps:get(TargetChar, ColumnCounts, 0),

                    % Val2 = (dp[I][J-1] * count(target[I], column J-1)) % MOD
                    % This represents ways to form target[0...I] by using column J-1 for target[I]
                    Val2 = (PrevPrevDpVal * CharCount) rem MOD,

                    % NewVal = (dp[I+1][J-1] + dp[I][J-1] * count(target[I], column J-1)) % MOD
                    NewVal = (Val1 + Val2) rem MOD,

                    % Update AccDpCurrentArray at index J (dp[I+1][J])
                    array:set(J, NewVal, AccDpCurrentArray)
                end,
                DpCurrentArray,
                lists:seq(1, WordLen)
            )
        end,
        DpPrevArray,
        lists:seq(0, TargetLen - 1) % Iterate over 0-indexed target character positions
    ),

    % The final answer is dp[TargetLen][WordLen]
    % FinalDpArray holds dp[TargetLen], so we get element at WordLen (0-indexed array access)
    array:get(WordLen, FinalDpArray).

precompute_counts(Words, WordLen) ->
    % InitialCounts is a list of empty maps, one for each column (0-indexed)
    InitialCounts = lists:duplicate(WordLen, #{}),

    % Fold over each word in the Words list
    lists:foldl(
        fun(Word, AccCounts) ->
            % For each word, iterate over its characters with their 0-indexed column position
            lists:foldl(
                fun({Char, ColIdx}, CurrentAccCounts) ->
                    % Get the map for the current column (1-indexed access for CurrentAccCounts list)
                    ColumnMap = lists:nth(ColIdx + 1, CurrentAccCounts), 
                    % Increment count for Char, default to 0 if Char not in map
                    NewCount = maps:get(Char, ColumnMap, 0) + 1,
                    % Update the map with the new count
                    NewColumnMap = maps:put(Char, NewCount, ColumnMap),
                    % Replace the old map in the list with the new one (1-indexed replacement)
                    lists:replace_nth(ColIdx + 1, NewColumnMap, CurrentAccCounts)
                end,
                AccCounts,
                % Pair each character with its 0-indexed column position
                lists:zip(Word, lists:seq(0, WordLen - 1)) 
            )
        end,
        InitialCounts,
        Words
    ).