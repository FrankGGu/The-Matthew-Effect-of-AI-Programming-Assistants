-module(chalkboard_xor).
-export([xorGame/1]).

xorGame(Nums) ->
  Sum = lists:foldl(fun(X, Acc) -> X xor Acc end, 0, Nums),
  case length(Nums) rem 2 == 0 orelse Sum == 0 of
    true -> true;
    false -> false
  end.