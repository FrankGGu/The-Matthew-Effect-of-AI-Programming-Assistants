-module(maximum_frequency).
-export([maximum_frequency/2]).

maximum_frequency(Nums, K) ->
    maximum_frequency(lists:sort(Nums), K, 0, 0, 0).

maximum_frequency(Nums, K, Left, Right, MaxFreq) when Right >= length(Nums) ->
    MaxFreq;
maximum_frequency(Nums, K, Left, Right, MaxFreq) ->
    Cost = lists:nth(Right + 1, Nums) * (Right - Left) - sum(lists:sublist(Nums, Left + 1, Right - Left));
    if Cost =< K ->
        NewMaxFreq = max(MaxFreq, Right - Left + 1),
        maximum_frequency(Nums, K, Left, Right + 1, NewMaxFreq);
    true ->
        maximum_frequency(Nums, K, Left + 1, Right, MaxFreq)
    end.