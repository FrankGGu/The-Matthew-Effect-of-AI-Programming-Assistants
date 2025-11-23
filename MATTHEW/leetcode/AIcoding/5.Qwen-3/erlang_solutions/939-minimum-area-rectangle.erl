-module(minimum_area_rectangle).
-export([minAreaRect/1]).

minAreaRect(Points) ->
    Set = sets:from_list(Points),
    Min = infinity,
    lists:foreach(fun({X1, Y1}) ->
        lists:foreach(fun({X2, Y2}) ->
            if
                X1 /= X2, Y1 /= Y2 ->
                    case sets:is_element({X1, Y2}, Set) andalso sets:is_element({X2, Y1}, Set) of
                        true ->
                            Area = abs((X2 - X1) * (Y2 - Y1)),
                            if Area < Min -> erlang:put(min, Area); true -> ok end;
                        false -> ok
                    end;
                true -> ok
            end
        end, Points)
    end, Points),
    erlang:get(min).

minAreaRect() ->
    minAreaRect([]).