-module(solution).
-export([number_of_black_blocks/3]).

number_of_black_blocks(M, N, Coordinates) ->
    SquaresMap = maps:new(),

    UpdatedSquaresMap = lists:foldl(
        fun([R, C], AccMap) ->
            CandidateTopLefts = [
                {R-1, C-1}, % (R,C) is bottom-right
                {R-1, C},   % (R,C) is bottom-left
                {R, C-1},   % (R,C) is top-right
                {R, C}      % (R,C) is top-left
            ],

            lists:foldl(
                fun({R_tl, C_tl}, InnerAccMap) ->
                    % Check if the top-left corner (R_tl, C_tl) is valid for a 2x2 square
                    % A 2x2 square exists if 0 <= R_tl < M-1 and 0 <= C_tl < N-1
                    if 
                        R_tl >= 0 andalso R_tl < M-1 andalso
                        C_tl >= 0 andalso C_tl < N-1 ->
                        maps:update_with({R_tl, C_tl}, fun(Val) -> Val + 1 end, 1, InnerAccMap);
                        true ->
                        InnerAccMap
                    end
                end,
                AccMap,
                CandidateTopLefts
            )
        end,
        SquaresMap,
        Coordinates
    ),

    % Initialize result tuple for counts of 0, 1, 2, 3, 4 black cells
    % Erlang tuples are 1-indexed:
    % element 1 for 0 black cells
    % element 2 for 1 black cell
    % ...
    % element 5 for 4 black cells
    AnsTuple = {0, 0, 0, 0, 0}, 

    % Populate AnsTuple based on counts in UpdatedSquaresMap
    FinalAnsTuple = maps:fold(
        fun(_Key, Count, AccAnsTuple) ->
            % Count can be 1, 2, 3, or 4
            % Map count to tuple index: Count -> Count + 1
            Index = Count + 1,
            CurrentValue = element(Index, AccAnsTuple),
            setelement(Index, AccAnsTuple, CurrentValue + 1)
        end,
        AnsTuple,
        UpdatedSquaresMap
    ),

    % Calculate total number of possible 2x2 squares
    Total2x2Squares = 
        if 
            M > 1 andalso N > 1 -> (M-1) * (N-1);
            true -> 0
        end,

    % Calculate the number of 2x2 squares with 0 black cells
    % This is Total2x2Squares - (sum of squares with 1, 2, 3, 4 black cells)
    Count1 = element(2, FinalAnsTuple),
    Count2 = element(3, FinalAnsTuple),
    Count3 = element(4, FinalAnsTuple),
    Count4 = element(5, FinalAnsTuple),

    SumOfNonZeroCounts = Count1 + Count2 + Count3 + Count4,

    Count0 = Total2x2Squares - SumOfNonZeroCounts,

    % Update the 0-count in the tuple (element 1)
    ResultTuple = setelement(1, FinalAnsTuple, Count0),

    % Convert the result tuple to a list as required
    tuple_to_list(ResultTuple).