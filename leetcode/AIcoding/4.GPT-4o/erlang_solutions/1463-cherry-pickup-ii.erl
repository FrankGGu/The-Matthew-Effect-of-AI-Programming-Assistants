-module(cherry_pickup_ii).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Array = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, -1)),
    MaxCherries(Grid, 0, 0, Cols - 1, Array).

MaxCherries(_, R, _, _, _) when R >= length(Grid) -> 0;
MaxCherries(Grid, R, C1, C2, Array) ->
    case Array:get(R + 1, C1 + 1) of
        -1 ->
            Cherries = if 
                C1 == C2 -> lists:nth(R + 1, lists:nth(C1 + 1, Grid));
                true -> lists:nth(R + 1, lists:nth(C1 + 1, Grid)) + lists:nth(R + 1, lists:nth(C2 + 1, Grid))
            end,
            Next = lists:foldl(fun(C, Acc) -> 
                lists:foldl(fun(C2, Acc2) -> 
                    Acc2 + MaxCherries(Grid, R + 1, C, C2, Array)
                end, Acc, [C1 - 1, C1, C1 + 1]) 
            end, 0, [C1 - 1, C1, C1 + 1]),
            Total = Cherries + Next,
            Array = Array#array{element = Total, index = {R + 1, C1 + 1}},
            Total;
        Total -> Total
    end.

cherry_pickup(Grid) ->
    MaxCherries(Grid, 0, 0, length(hd(Grid)) - 1, lists:duplicate(length(Grid) + 1, lists:duplicate(length(hd(Grid)) + 1, -1))).