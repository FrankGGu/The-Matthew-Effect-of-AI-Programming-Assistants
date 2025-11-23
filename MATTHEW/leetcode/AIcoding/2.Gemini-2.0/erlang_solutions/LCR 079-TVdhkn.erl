-module(subsets).
-export([subsets/1]).

subsets(Nums) ->
  lists:foldl(fun(N, Acc) ->
                  Acc ++ lists:map(fun(Subset) -> [N | Subset] end, Acc)
              end, [[]], Nums).