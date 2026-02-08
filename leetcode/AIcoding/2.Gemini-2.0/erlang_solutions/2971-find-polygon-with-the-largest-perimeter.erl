-module(largest_perimeter).
-export([largest_perimeter/1]).

largest_perimeter(Nums) ->
  SortedNums = lists:sort(Nums),
  {Sum, Result} = lists:foldl(
                     fun(Num, {AccSum, AccResult}) ->
                       if Num < AccSum then
                         {AccSum + Num, AccSum + Num}
                       else
                         {AccSum + Num, AccResult}
                       end
                     end,
                     {0, -1},
                     SortedNums
                   ),
  Result.