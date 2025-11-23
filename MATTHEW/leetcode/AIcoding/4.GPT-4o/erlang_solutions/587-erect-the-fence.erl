-module(solution).
-export([outer_trees/1]).

outer_trees(Points) ->
    PointsSorted = lists:sort(fun({X1, Y1}, {X2, Y2}) -> 
        case Y1 < Y2 of 
            true -> true; 
            false -> Y1 =:= Y2 andalso X1 < X2 
        end 
    end, Points),
    Upper = upper_hull(PointsSorted),
    Lower = lower_hull(PointsSorted),
    lists:usort(Upper ++ Lower).

upper_hull([]) -> [];
upper_hull([P | Ps]) ->
    upper_hull(Ps, [P]).

upper_hull([], Acc) -> Acc;
upper_hull([P | Ps], [Q | Rest]) ->
    case length(Rest) < 2 of
        true -> upper_hull(Ps, [P, Q | Rest]);
        false -> 
            case cross_product(Q, hd(Rest), P) > 0 of
                true -> upper_hull([P | Ps], [Q | Rest]);
                false -> upper_hull([P | Ps], [Q | Rest])
            end
    end.

lower_hull([]) -> [];
lower_hull(Points) ->
    lower_hull(lists:reverse(Points), []).

lower_hull([], Acc) -> Acc;
lower_hull([P | Ps], [Q | Rest]) ->
    case length(Rest) < 2 of
        true -> lower_hull(Ps, [P, Q | Rest]);
        false -> 
            case cross_product(Q, hd(Rest), P) < 0 of
                true -> lower_hull([P | Ps], [Q | Rest]);
                false -> lower_hull([P | Ps], [Q | Rest])
            end
    end.

cross_product({X1, Y1}, {X2, Y2}, {X3, Y3}) ->
    (X2 - X1) * (Y3 - Y1) - (Y2 - Y1) * (X3 - X1).