-module(powerful_integers).
-export([powerful_integers/3]).

powerful_integers(X, Y, Bound) ->
    Sets = sets:new(),
    ResultSets = calculate_x_powers(X, Y, Bound, 1, Sets),
    sets:to_list(ResultSets).

calculate_x_powers(X, Y, Bound, CurrentValX, AccSets) ->
    if
        CurrentValX > Bound ->
            AccSets;
        true ->
            SetsAfterY = calculate_y_powers(X, Y, Bound, CurrentValX, 1, AccSets),
            if
                X == 1 ->
                    SetsAfterY;
                true ->
                    NextValX = CurrentValX * X,
                    calculate_x_powers(X, Y, Bound, NextValX, SetsAfterY)
            end
    end.

calculate_y_powers(_X, Y, Bound, CurrentValX, CurrentValY, AccSets) ->
    Sum = CurrentValX + CurrentValY,
    if
        Sum > Bound ->
            AccSets;
        true ->
            NewAccSets = sets:add_element(Sum, AccSets),
            if
                Y == 1 ->
                    NewAccSets;
                true ->
                    NextValY = CurrentValY * Y,
                    calculate_y_powers(_X, Y, Bound, CurrentValX, NextValY, NewAccSets)
            end
    end.