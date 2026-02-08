-module(solution).
-export([max_equal_rows_after_flips/1]).

max_equal_rows_after_flips(Grid) ->
    MaxRows = 0,
    lists:foldl(fun(BaseRow, AccMax) ->
        % Determine the flip mask based on BaseRow.
        % If BaseRow[j] is 1, we want to flip column j to make it 0.
        % So, the flip mask is identical to BaseRow itself for XOR operation.
        FlipMask = BaseRow, 

        CurrentCounts = maps:new(),

        % Apply FlipMask to all rows in Grid and count frequencies of resulting patterns
        RowCounts = lists:foldl(fun(Row, AccCounts) ->
            % Apply the flip mask: TransformedRow[j] = Row[j] XOR FlipMask[j]
            TransformedRow = lists:zipwith(fun(Val, MaskVal) -> Val bxor MaskVal end, Row, FlipMask),

            % Convert transformed row to a string to be used as a map key
            % Adding $0 (ASCII for '0') converts integer 0 to character '0', 1 to '1'.
            RowString = lists:map(fun(X) -> $0 + X end, TransformedRow),

            Count = maps:get(RowString, AccCounts, 0),
            maps:put(RowString, Count + 1, AccCounts)
        end, CurrentCounts, Grid),

        % Find the maximum count among all transformed rows for this specific FlipMask
        CurrentMax = case maps:size(RowCounts) of
                         0 -> 0; % Should not happen if Grid is non-empty
                         _ -> lists:max(maps:values(RowCounts))
                     end,

        % Update the overall maximum
        max(AccMax, CurrentMax)
    end, MaxRows, Grid).