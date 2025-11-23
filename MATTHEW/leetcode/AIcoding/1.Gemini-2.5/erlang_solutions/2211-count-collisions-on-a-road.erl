-module(solution).
-export([countCollisions/1]).

countCollisions(Road) ->
    % Step 1: Remove leading 'L's
    StrippedLeading = strip_char_from_start($L, Road),

    % Step 2: Remove trailing 'R's
    % To remove trailing 'R's, reverse the list, strip leading 'R's, then reverse back.
    ReversedStrippedLeading = lists:reverse(StrippedLeading),
    StrippedTrailingReversed = strip_char_from_start($R, ReversedStrippedLeading),
    FinalStripped = lists:reverse(StrippedTrailingReversed),

    % Step 3: Count 'R's and 'L's in the remaining string.
    % This count represents the total number of cars that will change from moving to stationary.
    % Each such change corresponds to one collision count.
    % For an R-L collision, both R and L change state, contributing 2 to the count.
    % For an R-S or S-L collision, one car changes state, contributing 1 to the count.
    count_RL(FinalStripped).

strip_char_from_start(Char, [Char | T]) -> strip_char_from_start(Char, T);
strip_char_from_start(_Char, List) -> List.

count_RL([]) -> 0;
count_RL([$R | T]) -> 1 + count_RL(T);
count_RL([$L | T]) -> 1 + count_RL(T);
count_RL([_ | T]) -> count_RL(T). % Ignore 'S' characters, as they are already stationary and don't contribute to collision count directly.