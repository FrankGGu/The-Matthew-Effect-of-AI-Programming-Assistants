-module(solution).
-export([k_places_away/2]).

k_places_away(Nums, K) ->
    check(Nums, K, 0, -K - 1).

check([], _K, _CurrentIndex, _LastOneIndex) ->
    true;
check([H|T], K, CurrentIndex, LastOneIndex) ->
    case H of
        1 ->
            Distance = CurrentIndex - LastOneIndex - 1,
            if
                Distance < K ->
                    false;
                true ->
                    check(T, K, CurrentIndex + 1, CurrentIndex)
            end;
        0 ->
            check(T, K, CurrentIndex + 1, LastOneIndex)
    end.