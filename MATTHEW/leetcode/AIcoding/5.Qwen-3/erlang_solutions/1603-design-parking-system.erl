-module(parking_system).
-export([new/0, add_car/2]).

-record(parking, {big, medium, small}).

new() ->
    #parking{big = 0, medium = 0, small = 0}.

add_car(Parking, CarType) ->
    case CarType of
        1 -> 
            if Parking#parking.big < 50 -> {true, Parking#parking{big = Parking#parking.big + 1}}; true -> {false, Parking} end;
        2 -> 
            if Parking#parking.medium < 25 -> {true, Parking#parking{medium = Parking#parking.medium + 1}}; true -> {false, Parking} end;
        3 -> 
            if Parking#parking.small < 50 -> {true, Parking#parking{small = Parking#parking.small + 1}}; true -> {false, Parking} end
    end.