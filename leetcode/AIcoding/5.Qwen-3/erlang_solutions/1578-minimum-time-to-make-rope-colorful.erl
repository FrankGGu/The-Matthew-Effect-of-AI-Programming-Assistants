-module(minimum_time_to_make_rope_colorful).
-export([minCost/2]).

minCost(Color, NeededTime) ->
    minCost(Color, NeededTime, 0, 0).

minCost([], _, _, Acc) ->
    Acc;
minCost([H | T], [N | NT], Prev, Acc) ->
    if
        H == Prev ->
            minCost(T, NT, H, Acc + N);
        true ->
            minCost(T, NT, H, Acc)
    end.