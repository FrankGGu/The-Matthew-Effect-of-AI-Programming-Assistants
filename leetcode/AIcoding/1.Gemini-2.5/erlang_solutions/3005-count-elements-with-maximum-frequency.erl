-spec count_elements_with_maximum_frequency(Nums :: [integer()]) -> integer().
count_elements_with_maximum_frequency(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) ->
                                  maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                          end, maps:new(), Nums),

    case maps:is_empty(FreqMap) of
        true -> 0;
        false ->
            MaxFreq = maps:fold(fun(_K, V, Acc) ->
                                        max(V, Acc)
                                end, 0, FreqMap),

            TotalFreq = maps:fold(fun(_K, V, Acc) ->
                                          if V == MaxFreq -> Acc + V;
                                             true -> Acc
                                          end
                                  end, 0, FreqMap),
            TotalFreq
    end.