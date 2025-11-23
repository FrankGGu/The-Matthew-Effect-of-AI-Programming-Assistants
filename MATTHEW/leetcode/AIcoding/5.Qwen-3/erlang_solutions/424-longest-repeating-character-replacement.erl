-module(longest_repeating_character_replacement).
-export([character_replacement/2]).

character_replacement(S, K) ->
    Len = length(S),
    MaxCount = 0,
    Left = 0,
    Map = maps:new(),
    loop(S, K, Len, MaxCount, Left, Map).

loop(_, _, Len, MaxCount, Left, _) when Left >= Len ->
    MaxCount;
loop(S, K, Len, MaxCount, Left, Map) ->
    Right = Left + 1,
    Char = lists:nth(Right, S),
    Count = maps:get(Char, Map, 0) + 1,
    NewMap = maps:put(Char, Count, Map),
    CurrentWindow = Right - Left,
    case CurrentWindow - maps:max_value(NewMap) > K of
        true ->
            LeftChar = lists:nth(Left, S),
            NewMap2 = maps:update(LeftChar, maps:get(LeftChar, NewMap) - 1, NewMap),
            loop(S, K, Len, MaxCount, Left + 1, NewMap2);
        false ->
            NewMaxCount = max(MaxCount, Right - Left),
            loop(S, K, Len, NewMaxCount, Left, NewMap)
    end.