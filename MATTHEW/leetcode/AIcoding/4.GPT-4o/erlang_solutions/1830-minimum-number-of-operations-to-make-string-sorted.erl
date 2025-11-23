-module(solution).
-export([minimum_operations/1]).

minimum_operations(S) ->
    Length = string:length(S),
    Sorted = lists:sort(string:to_list(S)),
    Count = lists:foldl(fun(X, {Index, Acc}) -> 
                                {Index + 1, Acc + (lists:nth(Index + 1, Sorted) =:= X andalso 1 orelse 0)}
                        end, {0, 0}, string:to_list(S)),
    Length - element(2, Count).