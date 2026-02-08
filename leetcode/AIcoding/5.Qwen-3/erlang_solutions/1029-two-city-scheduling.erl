-module(two_city_scheduling).
-export([two_city_scheduling/1]).

two_city_scheduling(Costs) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, Costs),
    Total = lists:foldl(fun({A, B}, Acc) ->
        case Acc rem 2 of
            0 -> Acc + A;
            _ -> Acc + B
        end
    end, 0, Sorted),
    Total.