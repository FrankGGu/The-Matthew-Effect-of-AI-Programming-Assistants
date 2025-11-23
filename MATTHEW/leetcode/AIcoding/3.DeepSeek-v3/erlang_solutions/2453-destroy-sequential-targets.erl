-module(solution).
-export([destroy_targets/2]).

destroy_targets(Nums, Space) ->
    Counts = lists:foldl(fun(Num, Acc) ->
                            Key = Num rem Space,
                            maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Nums),
    MaxCount = case maps:size(Counts) of
                  0 -> 0;
                  _ -> lists:max(maps:values(Counts))
               end,
    Candidates = maps:fold(fun(Key, Val, Acc) ->
                              if Val == MaxCount -> [Key | Acc];
                                 true -> Acc
                              end
                           end, [], Counts),
    lists:min([lists:min([Num || Num <- Nums, Num rem Space == Key]) || Key <- Candidates]).