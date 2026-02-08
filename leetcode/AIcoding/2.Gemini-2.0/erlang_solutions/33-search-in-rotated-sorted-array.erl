-module(search_rotated_array).
-export([search/2]).

search(Nums, Target) ->
  search(Nums, Target, 0, length(Nums) - 1).

search(Nums, Target, Left, Right) when Left > Right ->
  -1;
search(Nums, Target, Left, Right) ->
  Mid = (Left + Right) div 2,
  case lists:nth(Mid + 1, Nums) of
    Target ->
      Mid;
    _ ->
      if lists:nth(Left + 1, Nums) =< lists:nth(Mid + 1, Nums) then
        if Target >= lists:nth(Left + 1, Nums) andalso Target < lists:nth(Mid + 1, Nums) then
          search(Nums, Target, Left, Mid - 1)
        else
          search(Nums, Target, Mid + 1, Right)
        else
          if Target > lists:nth(Mid + 1, Nums) andalso Target =< lists:nth(Right + 1, Nums) then
            search(Nums, Target, Mid + 1, Right)
          else
            search(Nums, Target, Left, Mid - 1)
          end
        end
  end.