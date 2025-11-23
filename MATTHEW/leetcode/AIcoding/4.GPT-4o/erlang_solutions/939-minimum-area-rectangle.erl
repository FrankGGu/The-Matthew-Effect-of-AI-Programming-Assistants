-module(solution).
-export([min_area_rectangle/1]).

min_area_rectangle(Points) ->
    PointSet = sets:from_list(Points),
    MinArea = lists:foldl(fun({X1, Y1}, Acc) ->
        lists:foldl(fun({X2, Y2}, Acc2) ->
            case X1 =:= X2 orelse Y1 =:= Y2 of
                true -> Acc2;
                false ->
                    case sets:is_element({X1, Y2}, PointSet) andalso sets:is_element({X2, Y1}, PointSet) of
                        true -> 
                            Area = abs((X2 - X1) * (Y2 - Y1)),
                            min(Area, Acc2);
                        false -> Acc2
                    end
            end
        end, Acc, Points)
    end, infinity, Points),
    case MinArea of
        infinity -> 0;
        _ -> MinArea
    end.