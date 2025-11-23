-module(maximum_split).
-export([maximum_split/1]).

maximum_split(FinalSum) ->
  maximum_split(FinalSum, 2, []).

maximum_split(0, _, Acc) ->
  lists:reverse(Acc);
maximum_split(FinalSum, Num, Acc) when FinalSum < Num ->
  lists:reverse(Acc -- [lists:last(Acc)]) ++ [lists:last(Acc) + FinalSum];
maximum_split(FinalSum, Num, Acc) when FinalSum =:= Num ->
  lists:reverse([Num | Acc]);
maximum_split(FinalSum, Num, Acc) ->
  maximum_split(FinalSum - Num, Num + 2, [Num | Acc]).

maximum_split(FinalSum) when FinalSum rem 2 /= 0 ->
  [].