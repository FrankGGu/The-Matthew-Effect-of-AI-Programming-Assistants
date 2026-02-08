-module(shortest_string).
-export([find_shortest_string/3]).

find_shortest_string(S1, S2, S3) ->
    {L1, L2, L3} = {length(S1), length(S2), length(S3)},
    MinLength = min(L1 + L2 + L3, min(L1 + L2, min(L1 + L3, L2 + L3))),
    lists:foldl(fun(X, Acc) -> string:concat(Acc, X) end, "", lists:sublist([S1, S2, S3], MinLength)).