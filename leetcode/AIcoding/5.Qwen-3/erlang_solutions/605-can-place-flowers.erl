-module(can_place_flowers).
-export([can_place_flowers/1]).

can_place_flowers(Flowerbed) ->
    can_place_flowers(Flowerbed, 0, 0).

can_place_flowers([], _Index, Count) ->
    Count >= 0;
can_place_flowers([0 | Rest], Index, Count) ->
    Prev = if Index == 0 -> 0; true -> lists:nth(Index - 1, Flowerbed) end,
    Next = if Index + 1 > length(Flowerbed) -> 0; true -> lists:nth(Index + 1, Flowerbed) end,
    if
        Prev == 0 andalso Next == 0 ->
            can_place_flowers(Rest, Index + 1, Count + 1);
        true ->
            can_place_flowers(Rest, Index + 1, Count)
    end;
can_place_flowers([1 | Rest], Index, Count) ->
    can_place_flowers(Rest, Index + 1, Count).