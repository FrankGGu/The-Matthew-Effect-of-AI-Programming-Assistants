-module(solution).
-export([longestSquareStreak/1]).

longestSquareStreak(Nums) ->
    SortedNums = lists:sort(Nums),

    % State: {MaxLen, StreakMap}
    % MaxLen: The maximum streak length found so far. Initialized to 1, as any single number forms a streak of length 1.
    % StreakMap: A map storing Number -> StreakLength for numbers encountered so far.
    {FinalMaxLen, _} = lists:foldl(
        fun(Num, {CurrentMaxLen, StreakMap}) ->
            PrevNumFloat = math:sqrt(Num),
            PrevNum = round(PrevNumFloat),

            % Check if Num is a perfect square of PrevNum and if PrevNum has an existing streak
            IsPerfectSquare = (PrevNum * PrevNum == Num),
            PrevNumInMap = maps:is_key(PrevNum, StreakMap),

            case IsPerfectSquare andalso PrevNumInMap of
                true ->
                    % Num can extend a streak ending at PrevNum
                    PrevStreakLen = maps:get(PrevNum, StreakMap),
                    CurrentStreakLen = PrevStreakLen + 1,
                    NewStreakMap = maps:put(Num, CurrentStreakLen, StreakMap),
                    {max(CurrentMaxLen, CurrentStreakLen), NewStreakMap};
                _ ->
                    % Num either doesn't extend a previous streak (not a perfect square of a seen number)
                    % or PrevNum itself doesn't exist in the map (meaning it wasn't part of a streak)
                    % In this case, Num starts a new streak of length 1.
                    CurrentStreakLen = 1,
                    NewStreakMap = maps:put(Num, CurrentStreakLen, StreakMap),
                    {CurrentMaxLen, NewStreakMap} % MaxLen doesn't change if CurrentStreakLen is 1, unless CurrentMaxLen was also 1.
            end
        end,
        {1, maps:new()}, % Initial accumulator: MaxLen = 1, empty StreakMap
        SortedNums
    ),

    % If FinalMaxLen is still 1, it means no streak of length > 1 was found.
    % The problem requires returning -1 in this case. Otherwise, return FinalMaxLen.
    case FinalMaxLen of
        1 -> -1;
        _ -> FinalMaxLen
    end.