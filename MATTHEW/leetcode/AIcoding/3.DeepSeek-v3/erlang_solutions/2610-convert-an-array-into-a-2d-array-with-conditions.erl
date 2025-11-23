-spec find_matrix(Items :: [integer()]) -> [[integer()]].
find_matrix(Items) ->
    Counts = lists:foldl(fun(Item, Acc) ->
                             maps:update_with(Item, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Items),
    Max = case maps:values(Counts) of
              [] -> 0;
              Vs -> lists:max(Vs)
          end,
    lists:map(fun(I) ->
                  maps:fold(fun(Key, Value, Acc) ->
                               if Value >= I -> [Key | Acc];
                                  true -> Acc
                               end
                            end, [], Counts)
              end, lists:seq(1, Max)).