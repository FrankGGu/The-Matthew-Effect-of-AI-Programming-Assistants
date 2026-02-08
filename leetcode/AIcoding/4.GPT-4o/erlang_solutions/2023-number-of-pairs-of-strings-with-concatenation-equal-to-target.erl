-module(solution).
-export([count_pairs/2]).

count_pairs(Strs, Target) ->
    Count = fun(Str) -> lists:foldl(fun(S, Acc) -> Acc + (string:len(S) + string:len(Str) =:= string:len(Target) andalso lists:sublist(Target, 1, string:len(S)) =:= S) end, 0, Strs) end,
    lists:foldl(fun(S, Acc) -> Acc + Count(S) end, 0, Strs) div 2.