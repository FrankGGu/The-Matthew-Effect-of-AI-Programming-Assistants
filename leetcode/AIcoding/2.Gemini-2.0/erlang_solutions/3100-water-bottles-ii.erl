-module(water_bottles_ii).
-export([water_bottles/4]).

water_bottles(capacityX, capacityY, amountX, amountY) ->
    Q = queue:new(),
    Visited = sets:new(),
    queue:in({amountX, amountY}, Q1) = queue:new(),
    sets:add({amountX, amountY}, Visited1) = sets:new(),
    water_bottles_helper(capacityX, capacityY, 0, Q1, Visited1).

water_bottles_helper(CapacityX, CapacityY, Acc, Q, Visited) ->
    case queue:is_empty(Q) of
        true ->
            Acc;
        false ->
            {value, {X, Y}, Q2} = queue:out(Q),
            NewAcc = max(Acc, X + Y),

            NextStates = [
                {CapacityX, Y},
                {X, CapacityY},
                {0, Y},
                {X, 0},
                {NewX1, NewY1} || NewX1 <- [max(0, X - (CapacityY - Y))], NewY1 <- [min(CapacityY, Y + X)],
                {NewX2, NewY2} || NewX2 <- [min(CapacityX, X + Y)], NewY2 <- [max(0, Y - (CapacityX - X))]
            ],

            FilteredNextStates = lists:filter(fun({NX, NY}) -> not sets:is_element({NX, NY}, Visited) end, NextStates),

            {NewQ, NewVisited} = lists:foldl(fun({NX, NY}, {AccQ, AccVisited}) ->
                                                    queue:in({NX, NY}, AccQ1) = AccQ,
                                                    sets:add({NX, NY}, AccVisited1) = AccVisited,
                                                    {AccQ1, AccVisited1}
                                            end, {Q2, Visited}, FilteredNextStates),

            water_bottles_helper(CapacityX, CapacityY, NewAcc, NewQ, NewVisited)
    end.