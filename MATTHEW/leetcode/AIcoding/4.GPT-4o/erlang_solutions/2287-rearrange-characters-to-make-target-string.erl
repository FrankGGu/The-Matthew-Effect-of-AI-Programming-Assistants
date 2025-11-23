-module(solution).
-export([rearrange_characters/2]).

rearrange_characters(S, T) ->
    CharCount = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, map:new(), string:to_charlist(S)),
    TargetCount = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, map:new(), string:to_charlist(T)),
    lists:foldl(fun({C, Count}, Acc) -> 
        case maps:get(C, TargetCount, 0) of
            0 -> Acc;
            TCount -> min(Count div TCount, Acc)
        end
    end, infinity, maps:to_list(CharCount).