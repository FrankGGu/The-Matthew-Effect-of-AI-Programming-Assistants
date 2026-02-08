-module(contiguous_array).
-export([findMaxLength/1]).

findMaxLength(Nums) ->
    findMaxLength(Nums, 0, 0, #{0 => -1}).

findMaxLength([], _, MaxLength, _) ->
    MaxLength;
findMaxLength([Num | Rest], Index, Count, Map) ->
    NewCount = case Num of
        0 -> Count - 1;
        1 -> Count + 1
    end,
    case maps:is_key(NewCount, Map) of
        true ->
            PrevIndex = maps:get(NewCount, Map),
            NewMaxLength = max(Index - PrevIndex, 0),
            findMaxLength(Rest, Index + 1, NewCount, Map#{} , max(NewMaxLength, 0));
        false ->
            findMaxLength(Rest, Index + 1, NewCount, Map#{NewCount => Index}, 0)
    end.

findMaxLength(Nums, Index, Count, Map, MaxLength) when Nums == [] ->
    max(MaxLength, 0);
findMaxLength([Num | Rest], Index, Count, Map, MaxLength) ->
    NewCount = case Num of
        0 -> Count - 1;
        1 -> Count + 1
    end,
    case maps:is_key(NewCount, Map) of
        true ->
            PrevIndex = maps:get(NewCount, Map),
            NewMaxLength = max(Index - PrevIndex, 0),
            findMaxLength(Rest, Index + 1, NewCount, Map, max(MaxLength, NewMaxLength));
        false ->
            findMaxLength(Rest, Index + 1, NewCount, Map#{NewCount => Index}, MaxLength)
    end.