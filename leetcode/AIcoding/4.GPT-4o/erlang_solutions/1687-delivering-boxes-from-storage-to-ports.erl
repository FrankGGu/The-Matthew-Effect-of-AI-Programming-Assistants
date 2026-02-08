-module(solution).
-export([boxDelivering/3]).

boxDelivering(Boxes, Ports, MaxBoxes) ->
    N = length(Boxes),
    Deliveries = lists:sum(Boxes),
    Trips = 0,
    boxDeliver(Boxes, Ports, MaxBoxes, N, Deliveries, Trips, 0).

boxDeliver([], _, _, _, _, Trips, _) -> Trips;
boxDeliver([H | T], Ports, MaxBoxes, N, Deliveries, Trips, Current) ->
    NewCurrent = Current + 1,
    NewDeliveries = Deliveries - H,
    if 
        NewCurrent > MaxBoxes -> 
            boxDeliver(T, Ports, MaxBoxes, N, Deliveries, Trips + 1, 1);
        true -> 
            boxDeliver(T, Ports, MaxBoxes, N, NewDeliveries, Trips, NewCurrent)
    end.