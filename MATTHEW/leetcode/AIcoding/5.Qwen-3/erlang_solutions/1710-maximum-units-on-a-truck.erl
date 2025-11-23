-module(maximum_units_on_a_truck).
-export([maximumUnits/2]).

maximumUnits(Boards, TruckSize) ->
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Boards),
    calculate(Sorted, TruckSize, 0).

calculate([], _, Acc) ->
    Acc;
calculate([{_, Units} | Rest], Size, Acc) when Size >= Units ->
    calculate(Rest, Size - Units, Acc + Units);
calculate([{_, Units} | Rest], Size, Acc) ->
    calculate(Rest, 0, Acc + Size).