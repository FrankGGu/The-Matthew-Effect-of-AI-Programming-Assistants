-module(solution).
-export([findLHS/1]).

findLHS(nums) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(_) -> 1 end, fun(N) -> N + 1 end, Acc) end, map:new(), nums),
    maps:fold(fun(Key, Value, Acc) ->
        case maps:is_key(Key + 1, Acc) of
            true -> 
                max(Value + maps:get(Key + 1, Acc), Acc);
            false -> 
                Acc
        end
    end, 0, Counts).