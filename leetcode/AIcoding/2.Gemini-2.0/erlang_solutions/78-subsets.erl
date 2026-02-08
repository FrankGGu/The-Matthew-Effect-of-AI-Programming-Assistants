-module(subsets).
-export([subsets/1]).

subsets(Nums) ->
  lists:foldl(
    fun(Num, Acc) ->
      lists:foldl(
        fun(Subset, Subsets) ->
          [Subset ++ [Num] | Subsets]
        end,
        Acc,
        Acc
      )
    end,
    [[]],
    Nums
  ).