-module(min_consecutive_cards).
-export([minimumCardPickup/1]).

minimumCardPickup(Cards) ->
    Map = maps:from_list([{Card, Index} || {Index, Card} <- lists:enumerate(Cards)]),
    min_consecutive(Map, Cards, 0, length(Cards)).

min_consecutive(_Map, [], _PrevIndex, Min) ->
    Min;
min_consecutive(Map, [Card | Rest], PrevIndex, Min) ->
    case maps:find(Card, Map) of
        {ok, Index} ->
            NewMin = min(Min, abs(Index - PrevIndex)),
            min_consecutive(Map, Rest, Index, NewMin);
        error ->
            min_consecutive(Map, Rest, PrevIndex, Min)
    end.