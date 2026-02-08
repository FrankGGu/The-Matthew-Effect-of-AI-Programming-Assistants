-module(brick_wall).
-export([least_bricks/1]).

least_bricks(Wall) ->
    Map = maps:new(),
    lists:foreach(fun(Row) -> 
        Acc = 0,
        lists:foldl(fun(Width, AccIn) ->
            NewAcc = AccIn + Width,
            if
                NewAcc /= lists:last(Row) -> 
                    maps:update_with(NewAcc, fun(V) -> V + 1 end, 1, Map);
                true -> ok
            end,
            NewAcc
        end, Acc, Row)
    end, Wall),
    case maps:values(Map) of
        [] -> 0;
        Values -> lists:max(Values)
    end.