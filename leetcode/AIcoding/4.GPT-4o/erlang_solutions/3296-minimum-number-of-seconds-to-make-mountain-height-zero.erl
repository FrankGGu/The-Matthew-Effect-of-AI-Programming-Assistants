-module(solution).
-export([minimum_seconds/1]).

minimum_seconds(Heights) ->
    MaxHeight = lists:max(Heights),
    lists:foldl(fun(H, Acc) -> Acc + (MaxHeight - H) end, 0, Heights).