-module(solution).
-export([check_straight_line/1]).

check_straight_line(Coordinates) ->
    [{X0, Y0} | Rest] = Coordinates,
    case Rest of
        [] -> true;
        _ ->
            {X1, Y1} = hd(Rest),
            DX = X1 - X0,
            DY = Y1 - Y0,
            lists:all(fun({X, Y}) ->
                              (Y - Y0) * DX =:= (X - X0) * DY
                          end, Rest)
    end.