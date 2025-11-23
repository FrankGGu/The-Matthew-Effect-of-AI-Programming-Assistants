-module(third_max).
-export([third_max/1]).

third_max(Nums) ->
  UniqueNums = lists:usort(Nums),
  Len = length(UniqueNums),
  if Len >= 3 ->
    lists:nth(Len - 2, UniqueNums);
  true ->
    lists:last(UniqueNums)
  end.