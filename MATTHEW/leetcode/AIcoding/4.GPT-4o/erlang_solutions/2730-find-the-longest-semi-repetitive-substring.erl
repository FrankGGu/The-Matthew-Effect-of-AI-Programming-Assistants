-module(solution).
-export([longest_semi_repetitive_substring/1]).

longest_semi_repetitive_substring(S) ->
    Length = string:length(S),
    longest_semi_repetitive_substring(S, Length, 0, 0, 0).

longest_semi_repetitive_substring(_, 0, MaxLen, _, _) -> 
    MaxLen;
longest_semi_repetitive_substring(S, Length, MaxLen, Start, Count) ->
    case Start of
        0 -> 
            longest_semi_repetitive_substring(S, Length - 1, MaxLen, Start + 1, Count);
        _ -> 
            Ch1 = string:at(S, Start),
            Ch2 = string:at(S, Start - 1),
            NewCount = if Ch1 == Ch2 -> Count + 1; true -> Count end,
            NewMaxLen = if NewCount > 1 -> MaxLen; true -> max(MaxLen, Start + 1) end,
            longest_semi_repetitive_substring(S, Length - 1, NewMaxLen, Start + 1, NewCount)
    end.