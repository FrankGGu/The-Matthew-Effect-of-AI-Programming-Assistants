-module(car_pooling).
-export([car_pooling/2]).

car_pooling(Trips, Capacity) ->
    Events = lists:sort(
        lists:foldl(
            fun([NumPassengers, From, To], Acc) ->
                [{From, NumPassengers}, {To, -NumPassengers}] ++ Acc
            end,
            [],
            Trips
        )
    ),

    FoldFun = fun({_, Passengers}, {CurrentCapacity, Result}) ->
        NewCapacity = CurrentCapacity + Passengers,
        if NewCapacity > Capacity then
            {NewCapacity, false}
        else
            {NewCapacity, Result}
        end
    end,

    {_, Result} = lists:foldl(FoldFun, {0, true}, Events),
    Result.