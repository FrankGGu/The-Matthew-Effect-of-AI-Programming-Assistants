-module(solution).
-export([find_max_length/1]).

find_max_length(Nums) ->
    Map = #{0 => -1},
    MaxLen = 0,
    Count = 0,
    find_max_length(Nums, Map, MaxLen, Count).

find_max_length([], _Map, MaxLen, _Count) ->
    MaxLen;

find_max_length([H | T], Map, MaxLen, Count) ->
    Count1 = case H of
        0 -> Count - 1;
        1 -> Count + 1
    end,
    case maps:find(Count1, Map) of
        {ok, Index} ->
            NewMaxLen = max(MaxLen, (length(T) + 1) - Index),
            find_max_length(T, Map, NewMaxLen, Count1);
        error ->
            NewMap = maps:put(Count1, length(T), Map),
            find_max_length(T, NewMap, MaxLen, Count1)
    end.