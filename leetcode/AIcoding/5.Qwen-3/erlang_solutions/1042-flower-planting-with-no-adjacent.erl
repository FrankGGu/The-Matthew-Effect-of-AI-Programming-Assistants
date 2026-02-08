-module(flower_planting_no_adjacent).
-export([can_place_flowers/1]).

can_place_flowers(Flowerbed) ->
    can_place_flowers(Flowerbed, 0, 0).

can_place_flowers([], _, Count) ->
    Count;
can_place_flowers([0 | Rest], Index, Count) ->
    case Index == 0 of
        true ->
            case lists:nth(Index + 2, Rest, 0) == 0 of
                true -> can_place_flowers(Rest, Index + 1, Count + 1);
                false -> can_place_flowers(Rest, Index + 1, Count)
            end;
        false ->
            case lists:nth(Index - 1, Flowerbed, 0) == 0 andalso lists:nth(Index + 2, Rest, 0) == 0 of
                true -> can_place_flowers(Rest, Index + 1, Count + 1);
                false -> can_place_flowers(Rest, Index + 1, Count)
            end
    end;
can_place_flowers([1 | Rest], Index, Count) ->
    can_place_flowers(Rest, Index + 1, Count).