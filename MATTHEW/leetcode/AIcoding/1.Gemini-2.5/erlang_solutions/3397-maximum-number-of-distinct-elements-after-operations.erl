-module(solution).
-export([maximum_distinct_elements/2]).

maximum_distinct_elements(Nums, K) ->
    FreqMap0 = lists:foldl(fun(N, Acc) ->
                               maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                           end, #{}, Nums),

    PQ0 = gb_trees:empty(),
    PQ1 = maps:fold(fun(Num, Count, AccPQ) ->
                        if Count > 1 ->
                            gb_trees:insert(Num, Num, AccPQ);
                           true ->
                            AccPQ
                        end
                    end, PQ0, FreqMap0),

    {FinalFreqMap, _FinalPQ} = perform_operations(K, FreqMap0, PQ1),

    maps:fold(fun(_Key, Count, Acc) ->
                  if Count > 0 -> Acc + 1;
                     true -> Acc
                  end
              end, 0, FinalFreqMap).

perform_operations(K, FreqMap, PQ) when K > 0 ->
    case gb_trees:take_max(PQ) of
        none ->
            {FreqMap, PQ};
        {{CurrentNum, _}, TempPQ} ->
            NewFreqMap1 = maps:update(CurrentNum, maps:get(CurrentNum, FreqMap) - 1, FreqMap),

            NextNum = CurrentNum div 2,

            NewFreqMap2 = maps:update_with(NextNum, fun(V) -> V + 1 end, 1, NewFreqMap1),

            PQ2 = if maps:get(CurrentNum, NewFreqMap2) > 1 ->
                      gb_trees:insert(CurrentNum, CurrentNum, TempPQ);
                     true ->
                      TempPQ
                  end,

            PQ3 = if maps:get(NextNum, NewFreqMap2) > 1 ->
                      gb_trees:insert(NextNum, NextNum, PQ2);
                     true ->
                      PQ2
                  end,

            perform_operations(K - 1, NewFreqMap2, PQ3)
    end;
perform_operations(0, FreqMap, PQ) ->
    {FreqMap, PQ}.