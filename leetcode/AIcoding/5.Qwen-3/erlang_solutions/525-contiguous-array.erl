-module(contiguous_array).
-export([find_max_length/1]).

find_max_length(Nums) ->
    Map = #{0 => -1},
    MaxLength = 0,
    Count = 0,
    find_max_length(Nums, Map, MaxLength, Count).

find_max_length([], _Map, MaxLength, _Count) ->
    MaxLength;

find_max_length([H | T], Map, MaxLength, Count) ->
    Count1 = case H of
        0 -> Count - 1;
        1 -> Count + 1
    end,
    case maps:find(Count1, Map) of
        {ok, Index} ->
            NewMaxLength = max(MaxLength, (length(Nums) - Index - 1)),
            find_max_length(T, Map, NewMaxLength, Count1);
        error ->
            NewMap = maps:put(Count1, length(Nums) - length(T) - 1, Map),
            find_max_length(T, NewMap, MaxLength, Count1)
    end.