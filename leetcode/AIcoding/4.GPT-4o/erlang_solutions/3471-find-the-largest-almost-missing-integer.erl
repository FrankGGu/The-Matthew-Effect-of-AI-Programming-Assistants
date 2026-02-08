-module(solution).
-export([findLargestMissingInteger/1]).

findLargestMissingInteger(List) ->
    Max = lists:max(List),
    Missing = lists:foldl(fun(X, Acc) -> if X > 0 andalso X < Max -> [X | Acc]; true -> Acc end end, [], List),
    case lists:filter(fun(X) -> lists:member(X + 1, Missing) end, Missing) of
        [] -> -1;
        L -> lists:max(L)
    end.