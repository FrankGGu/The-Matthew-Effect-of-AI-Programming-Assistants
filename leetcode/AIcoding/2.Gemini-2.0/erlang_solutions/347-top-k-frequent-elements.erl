-module(top_k_frequent).
-export([top_k_frequent/2]).

top_k_frequent(Nums, K) ->
  FreqMap = lists:foldl(fun(Num, Acc) ->
                                  case maps:is_key(Num, Acc) of
                                    true -> maps:update(Num, maps:get(Num, Acc) + 1, Acc);
                                    false -> maps:put(Num, 1, Acc)
                                  end
                              end, #{}, Nums),
  SortedList = lists:sort(fun( {_, V1}, {_, V2}) -> V1 > V2 end, maps:to_list(FreqMap)),
  [ Key || {Key, _} <- lists:sublist(SortedList, 1, K)].