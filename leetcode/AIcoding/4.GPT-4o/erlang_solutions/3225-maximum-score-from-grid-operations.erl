-module(solution).
-export([maxScore/2]).

maxScore(Grid, Operations) ->
    MaxRows = length(Grid),
    MaxCols = length(hd(Grid)),
    MaxGrid = lists:map(fun(Row) -> lists:map(fun(_) -> 0 end, Row) end, lists:duplicate(MaxRows, lists:duplicate(MaxCols, 0))),
    lists:foldl(fun({R, C}, Acc) -> 
        lists:map(fun({Row, Index}) -> 
            Row + lists:nth(C + 1, lists:nth(R + 1, Acc))
        end, lists:zip(Acc, lists:seq(1, MaxRows)))
    end, MaxGrid, Operations).