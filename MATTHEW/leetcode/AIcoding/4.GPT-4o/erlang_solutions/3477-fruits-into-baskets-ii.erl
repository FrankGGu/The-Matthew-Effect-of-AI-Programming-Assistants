-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    total_fruit(Fruits, 0, 0, 0, #{}).

total_fruit([], Max, _, Current, _) -> Max;
total_fruit([H | T], Max, Count, Current, Map) ->
    case maps:is_key(H, Map) of
        true ->
            total_fruit(T, Max, Count + 1, Current, Map);
        false ->
            NewCount = Count + 1,
            NewMap = maps:put(H, 1, Map),
            if
                maps:size(NewMap) > 2 ->
                    {NewMax, NewCurrent} = remove_fruit(T, Max, H, NewCount, NewMap),
                    total_fruit(NewCurrent, NewMax, NewCount - 1, Current, NewMap);
                true ->
                    total_fruit(T, Max, NewCount, Current, NewMap)
            end
    end.

remove_fruit([H | T], Max, Last, Count, Map) ->
    case maps:is_key(H, Map) of
        true ->
            total_fruit(T, Max, Count, Last, Map);
        false ->
            case maps:size(Map) of
                2 ->
                    case maps:find(Last, Map) of
                        {ok, _} ->
                            NewMap = maps:remove(Last, Map),
                            total_fruit(T, max(Max, Count), 0, H, NewMap);
                        error ->
                            total_fruit(T, Max, Count, Last, Map)
                    end;
                _ ->
                    total_fruit(T, Max, Count, Last, Map)
            end
    end.