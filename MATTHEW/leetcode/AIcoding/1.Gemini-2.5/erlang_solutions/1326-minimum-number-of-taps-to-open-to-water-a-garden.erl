-module(solution).
-export([min_taps/2]).

min_taps(N, Ranges) ->
    MaxReachArray = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

    UpdatedMaxReachArray = lists:foldl(
        fun({I, Range}, AccMaxReach) ->
            Left = max(0, I - Range),
            Right = min(N, I + Range),
            CurrentMax = array:get(Left, AccMaxReach),
            array:set(Left, max(CurrentMax, Right), AccMaxReach)
        end,
        MaxReachArray,
        lists:zip(lists:seq(0, N), Ranges)
    ),

    min_taps_greedy_loop(0, 0, 0, 0, N, UpdatedMaxReachArray).

min_taps_greedy_loop(I, CurrentCoveredEnd, FarthestPossibleReach, TapsCount, N, MaxReachArray) ->
    if
        CurrentCoveredEnd >= N ->
            TapsCount;
        I > N ->
            -1;
        true ->
            NewFarthestPossibleReach = max(FarthestPossibleReach, array:get(I, MaxReachArray)),

            if
                I == CurrentCoveredEnd ->
                    if
                        NewFarthestPossibleReach == CurrentCoveredEnd ->
                            -1;
                        true ->
                            min_taps_greedy_loop(I + 1, NewFarthestPossibleReach, NewFarthestPossibleReach, TapsCount + 1, N, MaxReachArray)
                    end;
                true ->
                    min_taps_greedy_loop(I + 1, CurrentCoveredEnd, NewFarthestPossibleReach, TapsCount, N, MaxReachArray)
            end
    end.