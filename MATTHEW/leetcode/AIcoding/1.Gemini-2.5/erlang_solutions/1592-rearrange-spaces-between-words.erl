-module(solution).
-export([reorderSpaces/1]).

reorderSpaces(Text) ->
    TotalSpaces = length(lists:filter(fun(C) -> C == $\s end, Text)),
    Words = lists:filter(fun(W) -> W /= [] end, re:split(Text, "[ ]+", [{return, list}, {trim, true}])),
    NumWords = length(Words),

    case NumWords of
        0 ->
            string:chars($\s, TotalSpaces);
        1 ->
            hd(Words) ++ string:chars($\s, TotalSpaces);
        _ ->
            SpacesBetweenWords = TotalSpaces div (NumWords - 1),
            RemainingSpaces = TotalSpaces rem (NumWords - 1),

            SpaceStr = string:chars($\s, SpacesBetweenWords),
            RemainingSpaceStr = string:chars($\s, RemainingSpaces),

            lists:join(SpaceStr, Words) ++ RemainingSpaceStr
    end.