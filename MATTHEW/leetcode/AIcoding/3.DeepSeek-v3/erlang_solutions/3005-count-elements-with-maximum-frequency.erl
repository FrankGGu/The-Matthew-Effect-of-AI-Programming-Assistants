-spec max_frequency_elements(Nums :: [integer()]) -> integer().
max_frequency_elements(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                          end, #{}, Nums),
    Frequencies = maps:values(FreqMap),
    MaxFreq = lists:max(Frequencies),
    lists:sum([F || F <- Frequencies, F =:= MaxFreq]).