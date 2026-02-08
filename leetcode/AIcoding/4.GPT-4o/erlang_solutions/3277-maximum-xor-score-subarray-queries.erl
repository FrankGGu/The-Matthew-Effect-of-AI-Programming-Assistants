-module(solution).
-export([max_xor_score/2]).

max_xor_score(Numbers, Queries) ->
    PrefixXor = lists:foldl(fun(X, Acc) -> [X bxor hd(Acc) | Acc] end, [0], Numbers),
    PrefixXorReversed = lists:reverse(PrefixXor),
    QueriesWithIndex = lists:zip(Queries, lists:seq(0, length(Queries) - 1)),
    MaxXor = fun(X, Acc) -> lists:max([X bxor Y || Y <- Acc]) end,
    lists:map(fun({{L, R}, Index}) ->
        MaxInRange = MaxXor(PrefixXorReversed[R + 1], lists:sublist(PrefixXorReversed, L + 1)),
        {Index, MaxInRange}
    end, QueriesWithIndex)
    |> lists:sort(fun({Idx1, _}, {Idx2, _}) -> Idx1 < Idx2 end)
    |> lists:map(fun({_, Val}) -> Val end).