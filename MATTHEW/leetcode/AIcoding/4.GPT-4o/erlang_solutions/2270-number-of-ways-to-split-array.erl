-module(solution).
-export([ways_to_split_array/1]).

ways_to_split_array(Array) ->
    N = length(Array),
    PrefixSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Array)),
    TotalSum = hd(PrefixSum),
    lists:foldl(fun(X, {Count, Acc}) ->
        NewAcc = Acc + X,
        if
            NewAcc * 2 < TotalSum -> {Count, Acc + 1};
            NewAcc * 2 > TotalSum -> {Count, Acc};
            true -> {Count + 1, Acc + 1}
        end
    end, {0, 0}, tl(PrefixSum))#{
        count => Count
    }.