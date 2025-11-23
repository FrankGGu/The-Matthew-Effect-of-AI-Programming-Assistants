-spec can_place_flowers(Flowerbed :: [integer()], N :: integer()) -> boolean().
can_place_flowers(Flowerbed, N) ->
    can_place_flowers(Flowerbed, N, 0, 0).

can_place_flowers([], N, Count, _) when Count >= N -> true;
can_place_flowers([], _, _, _) -> false;
can_place_flowers([1 | Rest], N, Count, _) ->
    can_place_flowers(Rest, N, Count, 1);
can_place_flowers([0 | Rest], N, Count, Prev) ->
    case Rest of
        [1 | _] -> can_place_flowers(Rest, N, Count, 0);
        [0 | _] when Prev =:= 0 -> can_place_flowers(Rest, N, Count + 1, 1);
        [] when Prev =:= 0 -> can_place_flowers([], N, Count + 1, 1);
        _ -> can_place_flowers(Rest, N, Count, 0)
    end.