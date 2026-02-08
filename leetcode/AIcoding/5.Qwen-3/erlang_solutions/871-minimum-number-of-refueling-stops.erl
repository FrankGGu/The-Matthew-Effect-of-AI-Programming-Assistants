-module(minimum_number_of_refueling_stops).
-export([car_fueling/2]).

car_fueling(Required, Stations) ->
    car_fueling(Required, Stations, 0, [], 0).

car_fueling(_, [], _, _, _) ->
    if
        Required =< 0 -> 0;
        true -> -1
    end;

car_fueling(Required, [[Distance, Fuel] | Rest], CurrentFuel, Heap, Count) ->
    NewFuel = CurrentFuel - Distance,
    if
        NewFuel < 0 ->
            case erl_heap:is_empty(Heap) of
                true -> -1;
                false ->
                    {MaxFuel, NewHeap} = erl_heap:pop(Heap),
                    car_fueling(Required + MaxFuel, [ [Distance, Fuel] | Rest ], NewFuel + MaxFuel, NewHeap, Count + 1)
            end;
        true ->
            car_fueling(Required, Rest, NewFuel, erl_heap:insert(Fuel, Heap), Count)
    end.