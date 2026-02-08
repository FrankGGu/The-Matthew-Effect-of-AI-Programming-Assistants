-spec total_fruit(Trees :: [integer()]) -> integer().
total_fruit(Trees) ->
    total_fruit(Trees, #{}, 0, 0, 0).

total_fruit([], _, _, Max, _) ->
    Max;
total_fruit([Type | Rest], Map, Start, Max, Current) ->
    case maps:is_key(Type, Map) of
        true ->
            NewMap = maps:update(Type, maps:get(Type, Map) + 1, Map),
            NewCurrent = Current + 1,
            NewMax = max(Max, NewCurrent),
            total_fruit(Rest, NewMap, Start, NewMax, NewCurrent);
        false ->
            case maps:size(Map) < 2 of
                true ->
                    NewMap = maps:put(Type, 1, Map),
                    NewCurrent = Current + 1,
                    NewMax = max(Max, NewCurrent),
                    total_fruit(Rest, NewMap, Start, NewMax, NewCurrent);
                false ->
                    {NewStart, NewMap} = remove_until(Rest, Map, Start, Type),
                    NewCurrent = Current - (NewStart - Start) + 1,
                    NewMax = max(Max, NewCurrent),
                    total_fruit(Rest, NewMap, NewStart, NewMax, NewCurrent)
            end
    end.

remove_until(Trees, Map, Start, NewType) ->
    remove_until(Trees, Map, Start, NewType, Start).

remove_until(_, Map, Start, NewType, Index) when maps:size(Map) < 2 ->
    {Index, maps:put(NewType, 1, Map)};
remove_until([Type | Rest], Map, Start, NewType, Index) ->
    case maps:get(Type, Map) of
        1 ->
            NewMap = maps:remove(Type, Map),
            {Index + 1, NewMap};
        Count ->
            NewMap = maps:update(Type, Count - 1, Map),
            remove_until(Rest, NewMap, Start, NewType, Index + 1)
    end.