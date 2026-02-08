-module(hand_of_straights).
-export([is_possible_to_split/1]).

is_possible_to_split(Hand) ->
    is_possible_to_split(Hand, maps:from_list(lists:sort(Hand)), 0).

is_possible_to_split([], _Map, _) ->
    true;
is_possible_to_split(Hand, Map, Start) ->
    case maps:find(Start, Map) of
        {ok, Count} when Count > 0 ->
            NewMap = update_map(Map, Start, -1),
            case check_sequence(NewMap, Start + 1, 1) of
                true ->
                    is_possible_to_split(Hand, NewMap, Start + 1);
                false ->
                    false
            end;
        _ ->
            is_possible_to_split(Hand, Map, Start + 1)
    end.

update_map(Map, Key, Delta) ->
    case maps:get(Key, Map, 0) of
        0 ->
            Map;
        Val ->
            maps:put(Key, Val + Delta, Map)
    end.

check_sequence(Map, Current, Steps) ->
    if
        Steps == length(Hand) ->
            true;
        true ->
            case maps:find(Current, Map) of
                {ok, Count} when Count > 0 ->
                    NewMap = update_map(Map, Current, -1),
                    check_sequence(NewMap, Current + 1, Steps + 1);
                _ ->
                    false
            end
    end.