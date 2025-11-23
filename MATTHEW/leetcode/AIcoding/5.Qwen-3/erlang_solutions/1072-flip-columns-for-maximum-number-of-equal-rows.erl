-module(solution).
-export([max_equal_rows/1]).

max_equal_rows(Matrix) ->
    Count = maps:new(),
    Rows = lists:map(fun(Row) -> 
        Key = lists:foldl(fun(Val, Acc) -> 
            case Val of
                0 -> [0 | Acc];
                1 -> [1 | Acc]
            end
        end, [], Row),
        Key
    end, Matrix),
    lists:foldl(fun(Key, Acc) ->
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, Count, Rows),
    maps:values(Count) ++ [0],
    lists:max(maps:values(Count)).