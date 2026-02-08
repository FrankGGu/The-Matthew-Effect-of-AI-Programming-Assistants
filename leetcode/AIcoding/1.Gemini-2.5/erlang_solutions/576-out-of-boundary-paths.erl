-module(solution).
-export([findPaths/5]).

findPaths(M, N, MaxMove, StartRow, StartColumn) ->
    Mod = 1000000007,

    % CurrentDP: A map where keys are {Row, Column} and values are the number of ways
    % to reach that cell in the current step.
    % Initially, only the start cell has 1 way to be reached (0 moves).
    CurrentDP = #{ {StartRow, StartColumn} => 1 },

    % TotalPaths: Accumulates the number of paths that go out of bounds.
    TotalPaths = 0,

    % Directions for movement: {DeltaRow, DeltaColumn}
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],

    % Iterate for each move from 1 up to MaxMove
    FinalResultTuple = lists:foldl(
        fun(_MoveNum, {AccTotalPaths, AccCurrentDP}) ->
            % NextDP: A new map to store counts for the next move.
            % It's initialized as an empty map for each iteration.
            NextDP = #{}, 

            % Iterate through all cells in AccCurrentDP (cells reachable in current step)
            % and calculate paths for the next step.
            {IterTotalPaths, IterNextDP} = maps:fold(
                fun({R, C}, Count, {FoldAccPaths, FoldAccNextDP}) ->
                    % For each cell (R, C) reachable in the current step with 'Count' ways,
                    % try moving in all 4 directions.
                    lists:foldl(
                        fun({DR, DC}, {InnerAccPaths, InnerAccNextDP}) ->
                            NewR = R + DR,
                            NewC = C + DC,

                            if
                                NewR < 0; NewR >= M; NewC < 0; NewC >= N ->
                                    % If the new position is out of bounds, add 'Count' to TotalPaths.
                                    {(InnerAccPaths + Count) rem Mod, InnerAccNextDP};
                                true ->
                                    % If the new position is in bounds, add 'Count' to its entry in NextDP.
                                    ExistingCount = maps:get({NewR, NewC}, InnerAccNextDP, 0),
                                    UpdatedNextDP = maps:put({NewR, NewC}, (ExistingCount + Count) rem Mod, InnerAccNextDP),
                                    {InnerAccPaths, UpdatedNextDP}
                            end
                        end,
                        {FoldAccPaths, FoldAccNextDP},
                        Directions
                    )
                end,
                {AccTotalPaths, NextDP}, % Initial accumulator for maps:fold
                AccCurrentDP
            ),

            % Return the updated total paths and the DP map for the next iteration.
            {IterTotalPaths, IterNextDP}
        end,
        {TotalPaths, CurrentDP}, % Initial accumulator for lists:foldl
        lists:seq(1, MaxMove)
    ),

    % The result is the accumulated total paths, which is the first element of the tuple.
    element(1, FinalResultTuple).