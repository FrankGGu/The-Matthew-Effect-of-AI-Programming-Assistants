-module(solution).
-export([find_median/1]).

find_median(Nums) ->
  Unique = lists:usort(Nums),
  Len = length(Unique),
  case Len rem 2 of
    0 ->
      Index1 = Len div 2 - 1,
      Index2 = Len div 2,
      (lists:nth(Index1 + 1, Unique) + lists:nth(Index2 + 1, Unique)) / 2.0;
    1 ->
      Index = Len div 2,
      lists:nth(Index + 1, Unique)
  end.