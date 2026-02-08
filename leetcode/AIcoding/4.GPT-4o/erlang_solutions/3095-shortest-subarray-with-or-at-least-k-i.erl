-module(solution).
-export([shortest_subarray/2]).

shortest_subarray(A, K) ->
    N = length(A),
    PrefixSums = lists:foldl(fun(X, Acc) -> [X + lists:nth(1, Acc)] ++ Acc end, [0], lists:reverse(A)),
    MinLength = lists:foldl(fun(Index, Acc) ->
        Target = K + lists:nth(Index + 1, PrefixSums),
        case lists:filter(fun(X) -> X >= Target end, lists:seq(0, Index)) of
            [] -> Acc;
            [Min | _] -> min(Acc, Index - Min)
        end
    end, N + 1, lists:seq(0, N - 1)),
    if MinLength > N -> -1; true -> MinLength end.