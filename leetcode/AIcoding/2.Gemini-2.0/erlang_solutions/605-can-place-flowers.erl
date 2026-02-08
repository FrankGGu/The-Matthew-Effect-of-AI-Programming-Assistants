-module(can_place_flowers).
-export([can_place_flowers/2]).

can_place_flowers(Flowerbed, N) ->
  can_place_flowers(Flowerbed, N, 0).

can_place_flowers([], N, Acc) ->
  Acc >= N;
can_place_flowers([0], N, Acc) ->
  Acc + 1 >= N;
can_place_flowers([0,0], N, Acc) ->
  Acc + 1 >= N;
can_place_flowers([0,0 | Rest], N, Acc) ->
  can_place_flowers(Rest, N, Acc + 1);
can_place_flowers([0,1 | Rest], N, Acc) ->
  can_place_flowers(Rest, N, Acc);
can_place_flowers([1 | Rest], N, Acc) ->
  can_place_flowers(Rest, N, Acc);
can_place_flowers([0,0,0 | Rest], N, Acc) ->
  can_place_flowers([0|Rest], N, Acc + 1);
can_place_flowers([0,0,0,0 | Rest], N, Acc) ->
  can_place_flowers([0,0|Rest], N, Acc + 1);
can_place_flowers([0 | Rest], N, Acc) ->
  can_place_flowers(Rest, N, Acc);
can_place_flowers([1], N, Acc) ->
  Acc >= N;
can_place_flowers([0,1], N, Acc) ->
  Acc >= N;
can_place_flowers([0,0,1], N, Acc) ->
    can_place_flowers([1], N, Acc+1);
can_place_flowers([0,0,0,1], N, Acc) ->
    can_place_flowers([1], N, Acc+1);
can_place_flowers([0,0,0,0,1], N, Acc) ->
    can_place_flowers([1], N, Acc+2);
can_place_flowers(Flowerbed, N, Acc) ->
    can_place_flowers(Flowerbed, N, Acc).