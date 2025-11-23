-module(solution).
-export([longest_arith_seq_length/1]).

longest_arith_seq_length(Nums) ->
    N = length(Nums),
    Dict = lists:foldl(fun(X, Acc) -> 
                          lists:foldl(fun(Y, Acc2) -> 
                                          Key = X - Y, 
                                          case maps:find(Key, Acc2) of 
                                              {ok, V} -> maps:update(Key, V + 1, Acc2);
                                              _ -> maps:update(Key, 1, Acc2)
                                          end
                                      end, Acc, lists:sublist(Nums, 0, lists:position(X, Nums) + 1))
                      end, maps:new(), Nums),
    maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Dict).