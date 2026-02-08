-module(parking_system).
-export([new/3, addCar/2]).

new(Big, Medium, Small) ->
    {Big, Medium, Small}.

addCar(CarType, {Big, Medium, Small} = State) ->
    case CarType of
        1 -> % Big car
            if Big > 0 ->
                {true, {Big - 1, Medium, Small}};
            true ->
                {false, State}
            end;
        2 -> % Medium car
            if Medium > 0 ->
                {true, {Big, Medium - 1, Small}};
            true ->
                {false, State}
            end;
        3 -> % Small car
            if Small > 0 ->
                {true, {Big, Medium, Small - 1}};
            true ->
                {false, State}
            end
    end.