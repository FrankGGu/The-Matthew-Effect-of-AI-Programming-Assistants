-module(solution).
-export([max_consecutive_floors/3]).

-spec max_consecutive_floors(Bottom :: integer(), Top :: integer(), Special :: [integer()]) -> integer().
max_consecutive_floors(Bottom, Top, Special) ->
    SortedSpecial = lists:sort(Special),

    Boundaries = [Bottom - 1 | SortedSpecial] ++ [Top + 1],

    [FirstBoundary | RestOfBoundaries] = Boundaries,

    {_LastBoundary, MaxLen} = lists:foldl(
        fun(CurrentBoundary, {PrevBoundary, AccMaxLen}) ->
            CurrentGapLen = CurrentBoundary - PrevBoundary - 1,
            {CurrentBoundary, max(AccMaxLen, CurrentGapLen)}
        end,
        {FirstBoundary, 0},
        RestOfBoundaries
    ),
    MaxLen.