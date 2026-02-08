-module(min_max_game).
-export([minMaxGame/1]).

minMaxGame(Nums) ->
  minMaxGameHelper(Nums).

minMaxGameHelper([Num]) ->
  Num;
minMaxGameHelper(Nums) ->
  N = length(Nums),
  NewNums = lists:foldl(fun(I, Acc) ->
    if (I rem 2) == 0 then
      [min(lists:nth(I+1, Nums), lists:nth(I+2, Nums))|Acc]
    else
      [max(lists:nth(I+1, Nums), lists:nth(I+2, Nums))|Acc]
    end
  end, [], lists:seq(0, N-2, 2)),
  minMaxGameHelper(lists:reverse(NewNums)).