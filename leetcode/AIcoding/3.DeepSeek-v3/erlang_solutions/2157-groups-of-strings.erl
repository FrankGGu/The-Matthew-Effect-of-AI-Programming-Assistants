-module(solution).
-export([group_strings/1]).

group_strings(Strings) ->
    Map = lists:foldl(fun(S, Acc) ->
        Key = lists:foldl(fun(C, K) -> 
            Diff = (C - lists:nth(1, S) + 26) rem 26,
            K ++ [Diff]
        end, [], S),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Strings),
    MaxSize = case maps:size(Map) of 0 -> 0; _ -> lists:max(maps:values(Map)) end,
    [maps:size(Map), MaxSize].