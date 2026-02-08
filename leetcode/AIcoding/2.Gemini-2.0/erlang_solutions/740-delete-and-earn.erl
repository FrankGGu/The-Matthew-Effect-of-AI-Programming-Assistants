-module(delete_and_earn).
-export([delete_and_earn/1]).

delete_and_earn(Nums) ->
  MaxNum = lists:max(Nums),
  Points = lists:foldl(fun(Num, Acc) ->
                                  maps:update_with(Num, fun(V) -> V + Num end, Num, Acc)
                          end, #{}, Nums),
  {Earn1, Earn2} = lists:foldl(fun(I, {Earn1Acc, Earn2Acc}) ->
                                   Earn = maps:get(I, Points, 0),
                                   NewEarn1 = max(Earn2Acc + Earn, Earn1Acc),
                                   {Earn1Acc, Earn}
                               end, {0, 0}, lists:seq(1, MaxNum)),
  max(Earn1, Earn2).