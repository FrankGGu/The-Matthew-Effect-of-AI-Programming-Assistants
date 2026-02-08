-module(maximum_containers_on_a_ship).
-export([max_boxes/2]).

max_boxes(Capacity, Boxes) ->
    max_boxes(Capacity, lists:sort(Boxes), 0).

max_boxes(_, [], Acc) ->
    Acc;
max_boxes(Capacity, [Box | Rest], Acc) ->
    if
        Box > Capacity ->
            max_boxes(Capacity, Rest, Acc);
        true ->
            max_boxes(Capacity, Rest, Acc + 1)
    end.