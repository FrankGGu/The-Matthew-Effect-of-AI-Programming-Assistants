-module(solution).
-export([findMaxInteger/1]).

findMaxInteger(List) ->
    Positives = lists:filter(fun(X) -> X > 0 end, List),
    Negatives = lists:map(fun(X) -> -X end, lists:filter(fun(X) -> X < 0 end, List)),
    lists:max(lists:filter(fun(X) -> lists:member(X, Negatives) end, Positives)).