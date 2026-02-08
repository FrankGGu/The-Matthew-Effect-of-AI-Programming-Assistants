-module(building_boxes).
-export([minimumBoxes/1]).

minimumBoxes(Blocks) ->
    minimumBoxes(Blocks, 0, 0).

minimumBoxes([], _, Acc) ->
    Acc;
minimumBoxes([H | T], Count, Acc) ->
    if
        H == 1 ->
            minimumBoxes(T, Count + 1, Acc + 1);
        true ->
            minimumBoxes(T, Count + 1, Acc + Count)
    end.