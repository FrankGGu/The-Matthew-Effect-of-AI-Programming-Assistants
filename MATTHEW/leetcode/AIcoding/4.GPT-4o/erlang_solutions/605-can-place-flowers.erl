-module(solution).
-export([can_place_flowers/2]).

can_place_flowers(Flowerbed, N) ->
    can_place_flowers(Flowerbed, N, 0).

can_place_flowers([], N, N) -> 
    true;
can_place_flowers([0 | Rest], N, Prev) when Prev =:= 0 ->
    can_place_flowers(Rest, N - 1, 1);
can_place_flowers([0 | Rest], N, Prev) ->
    can_place_flowers(Rest, N, 1);
can_place_flowers([1 | Rest], N, _) ->
    can_place_flowers(Rest, N, 0);
can_place_flowers([0 | Rest], N, Prev) ->
    can_place_flowers(Rest, N, Prev).