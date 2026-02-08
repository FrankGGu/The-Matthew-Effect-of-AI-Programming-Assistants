-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    FreqMap = lists:foldl(fun(Num, Acc) -> 
                            maps:update_with(Num, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, Nums),
    maps:fold(fun(_, Count, Acc) -> 
                 case Count of
                     1 -> -1;
                     2 -> Acc + 1;
                     3 -> Acc + 1;
                     _ when Count rem 3 == 0 -> Acc + Count div 3;
                     _ -> 
                         case (Count - 2) rem 3 of
                             0 -> Acc + (Count - 2) div 3 + 1;
                             _ -> 
                                 case (Count - 4) rem 3 of
                                     0 -> Acc + (Count - 4) div 3 + 2;
                                     _ -> -1
                                 end
                         end
                 end
              end, 0, FreqMap).