-module(distinct_difference_array).
-export([distinct_difference_array/1]).

distinct_difference_array(Nums) ->
  Len = length(Nums),
  lists:map(fun(I) ->
              PrefixDistinct = length(lists:usort(lists:sublist(Nums, 1, I))),
              SuffixDistinct = length(lists:usort(lists:sublist(Nums, I + 1, Len - I))),
              PrefixDistinct - SuffixDistinct
            end, lists:seq(1, Len)).