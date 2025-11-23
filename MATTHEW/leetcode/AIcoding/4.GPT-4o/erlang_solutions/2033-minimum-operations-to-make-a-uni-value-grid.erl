-module(solution).
-export([min_operations/1]).

min_operations(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Counts = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(X, Acc2) ->
            maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc2)
        end, Acc, Row)
    end, #{}, Grid),
    MaxCount = lists:max(maps:to_list(Counts)),
    N * M - MaxCount.