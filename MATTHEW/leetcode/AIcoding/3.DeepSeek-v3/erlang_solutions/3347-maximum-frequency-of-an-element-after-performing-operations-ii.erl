-spec max_frequency(Nums :: [integer()], Operations :: [[integer()]]) -> integer().
max_frequency(Nums, Operations) ->
    FreqMap = lists:foldl(fun(Num, Acc) -> 
                              maps:update_with(Num, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, Nums),
    UpdatedFreqMap = lists:foldl(fun([Index, Value], Acc) -> 
                                     OldNum = lists:nth(Index, Nums),
                                     NewNum = OldNum + Value,
                                     NewNums = lists:sublist(Nums, Index - 1) ++ [NewNum] ++ lists:nthtail(Index, Nums),
                                     NewAcc = maps:update_with(OldNum, fun(V) -> V - 1 end, Acc),
                                     NewAcc1 = case maps:get(OldNum, NewAcc, 0) of
                                                 0 -> maps:remove(OldNum, NewAcc);
                                                 _ -> NewAcc
                                             end,
                                     maps:update_with(NewNum, fun(V) -> V + 1 end, 1, NewAcc1)
                             end, FreqMap, Operations),
    case maps:size(UpdatedFreqMap) of
        0 -> 0;
        _ -> lists:max(maps:values(UpdatedFreqMap))
    end.