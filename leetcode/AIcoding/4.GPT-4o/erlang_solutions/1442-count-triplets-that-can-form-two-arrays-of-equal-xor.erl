-module(solution).
-export([countTriplets/1]).

countTriplets(List) ->
    N = length(List),
    PrefixXor = lists:foldl(fun(X, Acc) -> [X bxor hd(Acc) | Acc] end, [0], lists:reverse(List)),
    Counts = lists:foldl(fun(X, Acc) -> lists:map(fun(Y) -> X + Y end, Acc) ++ [X] end, [], PrefixXor),
    lists:foldl(fun(X, Acc) -> Acc + lists:count(X, PrefixXor) end, 0, Counts).