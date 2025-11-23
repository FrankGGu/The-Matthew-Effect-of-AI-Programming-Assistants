-module(solution).
-export([min_area_rect/1]).

min_area_rect(PointList) ->
    Points = maps:from_list(PointList),
    lists:foldl(fun({{X1, Y1}, {X2, Y2}}, Acc) ->
        case maps:is_key({X1, Y2}, Points) andalso maps:is_key({X2, Y1}, Points) of
            true -> 
                Area = abs(X1 - X2) * abs(Y1 - Y2),
                min(Area, Acc);
            false -> 
                Acc
        end
    end, infinity, lists:combinations(2, PointList)).