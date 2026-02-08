-module(distribute_money_to_max_children).
-export([maximumChildren/2]).

maximumChildren(Money, Cost) ->
    Max = Money div Cost,
    if
        Max == 0 -> 0;
        true -> 
            Remaining = Money rem Cost,
            if
                Remaining == 0 -> Max;
                true -> Max - 1
            end
    end.