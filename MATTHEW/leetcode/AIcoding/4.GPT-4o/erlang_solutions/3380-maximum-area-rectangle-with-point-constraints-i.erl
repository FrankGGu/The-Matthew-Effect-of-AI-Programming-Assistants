-module(max_area_rectangle).
-export([max_area/2]).

max_area(Points, Constraints) ->
    Points1 = lists:sort(Points),
    Constraints1 = lists:sort(Constraints),
    MaxArea = lists:foldl(fun(P1, Acc) ->
        case lists:keyfind(P1, 1, Constraints1) of
            false -> Acc;
            {_, Y1} ->
                lists:foldl(fun(P2, Acc2) ->
                    case lists:keyfind(P2, 0, Constraints1) of
                        false -> Acc2;
                        {_, Y2} ->
                            Area = abs(P1 - P2) * abs(Y1 - Y2),
                            lists:max([Area, Acc2])
                    end
                end, Acc, Points1)
        end
    end, 0, Points1),
    MaxArea.