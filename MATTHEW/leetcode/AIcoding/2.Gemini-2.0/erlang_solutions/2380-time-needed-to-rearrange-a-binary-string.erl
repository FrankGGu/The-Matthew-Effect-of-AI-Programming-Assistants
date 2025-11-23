-module(time_needed_to_rearrange).
-export([secondsToRemoveOccurrences/1]).

secondsToRemoveOccurrences(S) ->
    secondsToRemoveOccurrences_helper(S, 0).

secondsToRemoveOccurrences_helper(S, Acc) ->
    case string:str(S, "01") of
        0 ->
            Acc;
        Pos ->
            NewS = string:substr(S, 1, Pos - 1) ++ "10" ++ string:substr(S, Pos + 2, length(S)),
            secondsToRemoveOccurrences_helper(NewS, Acc + 1)
    end.