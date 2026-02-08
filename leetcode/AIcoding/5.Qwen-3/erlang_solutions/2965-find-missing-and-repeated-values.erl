-module(solution).
-export([find_missing_and_repeated_values/1]).

find_missing_and_repeated_values(Grid) ->
    N = length(Grid),
    Map = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Num, Acc2) ->
            maps:update(Num, 1 + maps:get(Num, Acc2, 0), Acc2)
        end, Acc, Row)
    end, maps:new(), Grid),
    lists:foldl(fun({Num, Count}, {Missing, Repeated}) ->
        if
            Count == 2 -> {Missing, Num};
            Count == 0 -> {Num, Repeated};
            true -> {Missing, Repeated}
        end
    end, {0, 0}, maps:to_list(Map)).