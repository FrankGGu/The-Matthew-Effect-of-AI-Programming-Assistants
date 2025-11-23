-module(sign_product).
-export([arraySign/1]).

arraySign(Nums) ->
  lists:foldl(fun(N, Acc) ->
                  case N of
                    0 -> 0;
                    _ when N < 0 -> Acc * -1;
                    _ -> Acc
                  end
              end, 1, Nums).