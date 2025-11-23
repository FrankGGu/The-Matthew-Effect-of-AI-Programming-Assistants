-module(parking_system).
-export([new/3, add_car/1]).

-record(parking, {big, medium, small}).

new(Big, Medium, Small) ->
    #parking{big = Big, medium = Medium, small = Small}.

add_car(Parking, 1) ->
    if
        Parking#parking.big > 0 ->
            {ok, Parking#parking{big = Parking#parking.big - 1}};
        true ->
            {error, Parking}
    end;
add_car(Parking, 2) ->
    if
        Parking#parking.medium > 0 ->
            {ok, Parking#parking{medium = Parking#parking.medium - 1}};
        true ->
            {error, Parking}
    end;
add_car(Parking, 3) ->
    if
        Parking#parking.small > 0 ->
            {ok, Parking#parking{small = Parking#parking.small - 1}};
        true ->
            {error, Parking}
    end;
add_car(_, _) ->
    {error, none}.