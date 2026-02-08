-module(apply_operations).
-export([max_frequency_score/2]).

max_frequency_score(Nums, K) ->
  SortedNums = lists:sort(Nums),
  {_, Result} = lists:foldl(fun(Num, {Map, Max}) ->
                                  {NewMap, NewMax} = update_map(Num, Map, K),
                                  {NewMap, max(NewMax, Max)}
                              end, {{}, 0}, SortedNums),
  Result.

update_map(Num, Map, K) ->
  NewMap = maps:update_with(Num, fun(Count) -> Count + 1 end, 1, Map),
  Keys = maps:keys(NewMap),
  SortedKeys = lists:sort(Keys),
  {NewMap2, TotalCost} = lists:foldl(fun(Key, {AccMap, Cost}) ->
                                          if Key < Num ->
                                            Diff = Num - Key,
                                            Count = maps:get(Key, AccMap),
                                            NewCost = Cost + Diff * Count,
                                            if NewCost > K ->
                                              {AccMap, NewCost}
                                            else
                                              maps:remove(Key, AccMap),
                                              {AccMap, NewCost}
                                            end;
                                            true ->
                                              {AccMap, Cost}
                                          end
                                      end, {NewMap, 0}, lists:reverse(lists:sublist(SortedKeys, 1, length(SortedKeys) -1 ))),

  {NewMap2, maps:get(Num, NewMap) }.