-module(solution).
-export([least_bricks/1]).

least_bricks(Walls) ->
    Counts = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Width, Acc2) ->
            case lists:keyfind(Width, 1, Acc2) of
                false -> [{Width, 1} | Acc2];
                {Width, Count} -> [{Width, Count + 1} | lists:keydelete(Width, 1, Acc2)]
            end
        end, Acc, Row)
    end, [], Walls),
    MaxCount = lists:max(lists:map(fun({_, Count}) -> Count end, Counts)),
    length(Walls) - MaxCount.