-module(solution).
-export([count_points/2]).

count_points(Rings, Rods) ->
    RodsCount = lists:duplicate(10, 0),
    lists:foldl(fun({Ring, Rod}, Acc) ->
        NewAcc = Acc#{} + 1,
        case Ring of
            $R -> Acc#{} + 1;
            $G -> Acc#{} + 2;
            $B -> Acc#{} + 4
        end
    end, RodsCount, lists:zip(lists:seq(1, length(Rings) div 2), lists:sublist(Rings, 2))).