-module(unique_substrings_in_wraparound_string).
-export([find_unique_substrings/1]).

find_unique_substrings(S) ->
    Map = maps:new(),
    MaxLen = 0,
    find_unique_substrings(S, 0, Map, MaxLen).

find_unique_substrings([], _, _, MaxLen) ->
    MaxLen;
find_unique_substrings([C | Rest], Pos, Map, MaxLen) ->
    NextPos = Pos + 1,
    case Pos of
        0 ->
            NewMap = maps:update_with(C, fun(V) -> max(V, 1) end, 1, Map),
            find_unique_substrings(Rest, NextPos, NewMap, MaxLen + 1);
        _ ->
            PrevChar = lists:nth(Pos, S),
            if (PrevChar + 1) rem 26 == C -> % Check wrap around
                CurrentLen = maps:get(C, Map, 0) + 1,
                NewMap = maps:update_with(C, fun(V) -> max(V, CurrentLen) end, CurrentLen, Map),
                find_unique_substrings(Rest, NextPos, NewMap, MaxLen + 1);
            true ->
                NewMap = maps:update_with(C, fun(V) -> max(V, 1) end, 1, Map),
                find_unique_substrings(Rest, NextPos, NewMap, MaxLen + 1)
            end
    end.