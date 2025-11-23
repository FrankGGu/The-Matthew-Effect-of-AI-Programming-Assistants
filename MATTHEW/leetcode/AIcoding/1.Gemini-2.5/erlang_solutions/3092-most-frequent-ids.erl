-module(solution).
-export([most_frequent_ids/1]).

most_frequent_ids(Operations) ->
    lists:reverse(
        lists:foldl(
            fun({Id, Change}, {IdToCount, CountToFreqGbTree, Acc}) ->
                OldCount = maps:get(Id, IdToCount, 0),
                NewCount = OldCount + Change,

                % Update CountToFreqGbTree for OldCount (if it was positive)
                NewCountToFreqGbTree1 = 
                    if OldCount > 0 ->
                        OldCountFreq = gb_trees:get(OldCount, CountToFreqGbTree),
                        if OldCountFreq == 1 ->
                            gb_trees:delete(OldCount, CountToFreqGbTree);
                        true ->
                            gb_trees:update(OldCount, OldCountFreq - 1, CountToFreqGbTree)
                        end;
                    true -> % OldCount was 0 or negative, so it wasn't in CountToFreqGbTree
                        CountToFreqGbTree
                    end,

                % Update CountToFreqGbTree for NewCount (if it is positive)
                NewCountToFreqGbTree2 = 
                    if NewCount > 0 ->
                        NewCountFreq = gb_trees:get(NewCount, NewCountToFreqGbTree1, 0),
                        gb_trees:update(NewCount, NewCountFreq + 1, NewCountToFreqGbTree1);
                    true -> % NewCount is 0 or negative, so it shouldn't be in CountToFreqGbTree
                        NewCountToFreqGbTree1
                    end,

                % Update IdToCount map
                NewIdToCount = maps:put(Id, NewCount, IdToCount),

                % Determine CurrentMaxFreq
                CurrentMaxFreq = 
                    if gb_trees:is_empty(NewCountToFreqGbTree2) ->
                        0;
                    true ->
                        {MaxKey, _} = gb_trees:largest(NewCountToFreqGbTree2),
                        MaxKey
                    end,

                {NewIdToCount, NewCountToFreqGbTree2, [CurrentMaxFreq | Acc]}
            end,
            {#{}, gb_trees:empty(), []}, % Initial state
            Operations
        )
    ).