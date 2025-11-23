-spec minimum_card_pickup(Cards :: [integer()]) -> integer().
minimum_card_pickup(Cards) ->
    Len = length(Cards),
    % InitialMinDist acts as an "infinity" value.
    % The maximum possible distance is Len, so Len + 1 is a safe initial value.
    InitialMinDist = Len + 1,
    % The last argument, InitialMinDist, is used as a marker to check if any duplicate was found.
    solve(Cards, 0, maps:new(), InitialMinDist, InitialMinDist).

solve([], _Index, _SeenMap, MinDist, InitialMinDistMarker) ->
    % If MinDist is still the InitialMinDistMarker, it means no duplicate was found.
    case MinDist of
        InitialMinDistMarker ->
            -1;
        _ ->
            MinDist
    end;
solve([Card | Rest], Index, SeenMap, CurrentMinDist, InitialMinDistMarker) ->
    case maps:find(Card, SeenMap) of
        {ok, LastSeenIndex} ->
            % Card has been seen before. Calculate the distance.
            Distance = Index - LastSeenIndex + 1,
            NewMinDist = min(CurrentMinDist, Distance),
            % Update the map with the current index for this card.
            NewSeenMap = maps:put(Card, Index, SeenMap),
            solve(Rest, Index + 1, NewSeenMap, NewMinDist, InitialMinDistMarker);
        error ->
            % Card not seen before. Add it to the map with its current index.
            NewSeenMap = maps:put(Card, Index, SeenMap),
            solve(Rest, Index + 1, NewSeenMap, CurrentMinDist, InitialMinDistMarker)
    end.