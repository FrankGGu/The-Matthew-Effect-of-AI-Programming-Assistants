-module(solution).
-export([solve/1]).

solve(Box) ->
    case Box of
        [] ->
            []; % If the box is empty, the result is an empty string
        _ ->
            % Determine the maximum length among all strings in the box
            MaxLen = lists:max([length(S) || S <- Box]),

            % Generate the result string by iterating through column indices
            % For each column index I (0 to MaxLen-1):
            % 1. Collect all characters at position I from strings that are long enough.
            % 2. Find the maximum character among these collected characters.
            % This forms the character at the current position in the result string.
            [lists:max([lists:nth(I + 1, S) || S <- Box, length(S) > I])
             || I <- lists:seq(0, MaxLen - 1)]
    end.