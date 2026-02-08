-module(solution).
-export([uncommon_from_sentences/2]).

uncommon_from_sentences(S1, S2) ->
    Words1 = string:tokens(S1, " "),
    Words2 = string:tokens(S2, " "),
    Count1 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(X) -> X + 1 end, 1, Acc) end, #{}, Words1),
    Count2 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(X) -> X + 1 end, 1, Acc) end, #{}, Words2),
    UncommonWords1 = maps:filter(fun(_, V) -> V == 1 end, Count1),
    UncommonWords2 = maps:filter(fun(_, V) -> V == 1 end, Count2),
    lists:append(maps:keys(UncommonWords1), maps:keys(UncommonWords2)).