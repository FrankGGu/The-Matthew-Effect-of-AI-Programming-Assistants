-module(solution).
-export([canPlaceFlowers/2]).

canPlaceFlowers(Flowerbed, N) when N =< 0 ->
    true;
canPlaceFlowers(Flowerbed, N) ->
    PaddedFlowerbed = [0 | Flowerbed ++ [0]],
    canPlaceFlowers_loop(PaddedFlowerbed, N).

canPlaceFlowers_loop(_ListSegment, 0) ->
    true;
canPlaceFlowers_loop(ListSegment, N) when length(ListSegment) < 3 ->
    N =< 0;
canPlaceFlowers_loop([L, C, R | Tail], N) ->
    case {L, C, R} of
        {0, 0, 0} ->
            canPlaceFlowers_loop([R | Tail], N - 1);
        _ ->
            canPlaceFlowers_loop([C, R | Tail], N)
    end.