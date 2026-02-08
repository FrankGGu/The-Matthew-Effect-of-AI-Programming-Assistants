-module(smaller_numbers).
-export([smaller_numbers_than_current/1]).

smaller_numbers_than_current(Nums) ->
  ListLength = length(Nums),
  Result = [count_smaller(Num, Nums) || Num <- Nums],
  Result.

count_smaller(Num, Nums) ->
  lists:foldl(fun(X, Acc) ->
                  case X < Num of
                    true -> Acc + 1;
                    false -> Acc
                  end
              end, 0, Nums).