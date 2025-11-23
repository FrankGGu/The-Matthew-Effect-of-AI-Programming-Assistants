-module(solution).
-export([ways_to_split/1]).

ways_to_split(Array) ->
    N = length(Array),
    PrefixSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Array)),
    PrefixSum1 = lists:reverse(PrefixSum),
    ways_to_split_helper(PrefixSum1, N, 0).

ways_to_split_helper(PrefixSum, N, Count) ->
    case N of
        0 -> Count;
        _ ->
            Current = hd(PrefixSum),
            Rest = tl(PrefixSum),
            Count1 = if Current >= 1 -> Count + 1; true -> Count end,
            ways_to_split_helper(Rest, N - 1, Count1)
    end.