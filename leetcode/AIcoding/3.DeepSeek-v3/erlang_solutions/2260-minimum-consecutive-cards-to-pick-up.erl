-spec minimum_card_pickup(Cards :: [integer()]) -> integer().
minimum_card_pickup(Cards) ->
    Map = maps:new(),
    {Min, _} = lists:foldl(fun(Card, {CurrentMin, AccMap}) ->
        case maps:get(Card, AccMap, undefined) of
            undefined ->
                {CurrentMin, maps:put(Card, erlang:length(AccMap), AccMap)};
            Pos ->
                Distance = erlang:length(AccMap) - Pos,
                NewMin = case CurrentMin of
                    -1 -> Distance;
                    _ -> min(CurrentMin, Distance)
                end,
                {NewMin, maps:put(Card, erlang:length(AccMap), AccMap)}
        end
    end, {-1, Map}, Cards),
    Min.