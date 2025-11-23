-module(heaters).
-export([heat/2]).

heat(Houses, Heaters) ->
    SortedHeaters = lists:sort(Heaters),
    lists:foldl(fun(House, Acc) ->
        case find_closest_heater(House, SortedHeaters) of
            {ok, Dist} -> max(Dist, Acc);
            _ -> Acc
        end
    end, 0, Houses).

find_closest_heater(House, Heaters) ->
    find_closest(House, Heaters, 0, length(Heaters) - 1).

find_closest(_, [], _, _) -> error;
find_closest(House, [H|_], L, _) when H >= House ->
    {ok, H - House};
find_closest(House, [H|T], L, R) ->
    case find_closest(House, T, L + 1, R) of
        {ok, D} when D < H - House -> {ok, D};
        _ -> {ok, H - House}
    end;
find_closest(House, [H|T], L, R) ->
    case find_closest(House, T, L + 1, R) of
        {ok, D} -> {ok, D};
        _ -> {ok, House - H}
    end.