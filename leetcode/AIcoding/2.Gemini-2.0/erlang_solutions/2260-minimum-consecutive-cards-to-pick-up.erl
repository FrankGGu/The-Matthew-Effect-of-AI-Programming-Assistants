-module(minimum_consecutive_cards).
-export([minimum_card_pickup/1]).

minimum_card_pickup(Cards) ->
    minimum_card_pickup(Cards, #{}, 1, infinity).

minimum_card_pickup([], _, _, Min) ->
    case Min =:= infinity of
        true -> -1;
        false -> Min
    end;
minimum_card_pickup([H|T], Map, Index, Min) ->
    case maps:is_key(H, Map) of
        true ->
            PrevIndex = maps:get(H, Map),
            NewMin = min(Min, Index - PrevIndex + 1),
            minimum_card_pickup(T, Map#{H => Index}, Index + 1, NewMin);
        false ->
            minimum_card_pickup(T, Map#{H => Index}, Index + 1, Min)
    end.