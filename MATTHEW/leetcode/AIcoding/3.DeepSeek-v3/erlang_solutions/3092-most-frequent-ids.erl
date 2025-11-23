-module(solution).
-export([most_frequent/2]).

most_frequent(Nums, Ks) ->
    {_, Result} = lists:foldl(fun process_fold/2, {#{}, []}, lists:zip(Nums, Ks)),
    lists:reverse(Result).

process_fold({Num, K}, {FreqMap, Acc}) ->
    NewFreqMap = case maps:get(Num, FreqMap, 0) of
        Count -> maps:put(Num, Count + 1, FreqMap)
    end,
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(NewFreqMap)),
    TopK = case length(Sorted) >= K of
        true -> lists:sublist(Sorted, K);
        false -> Sorted
    end,
    MaxFreq = case TopK of
        [] -> 0;
        [{_, Freq} | _] -> Freq
    end,
    {NewFreqMap, [MaxFreq | Acc]}.