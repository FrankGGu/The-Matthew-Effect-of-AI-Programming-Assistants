-module(single_number_iii).
-export([single_number/1]).

single_number(Nums) ->
  Xor = lists:foldl(fun(X, Acc) -> X xor Acc end, 0, Nums),
  RightmostSetBit = Xor band -Xor,
  {Num1, Num2} = lists:foldl(fun(Num, {N1, N2}) ->
                                 if (Num band RightmostSetBit) == 0 ->
                                   {N1 xor Num, N2};
                                 true ->
                                   {N1, N2 xor Num}
                                 end
                               end, {0, 0}, Nums),
  [Num1, Num2].