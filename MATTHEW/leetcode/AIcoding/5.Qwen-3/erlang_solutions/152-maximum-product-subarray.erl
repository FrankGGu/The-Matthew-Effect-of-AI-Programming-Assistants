-module(maximum_product_subarray).
-export([maxProduct/1]).

maxProduct(Nums) ->
    maxProduct(Nums, 1, 1, hd(Nums)).

maxProduct([], _, _, Max) ->
    Max;
maxProduct([H | T], Left, Right, Max) ->
    Left1 = case Left of
                0 -> H;
                _ -> Left * H
            end,
    Right1 = case Right of
                 0 -> H;
                 _ -> Right * H
             end,
    NewMax = max(Max, Left1, Right1),
    maxProduct(T, Left1, Right1, NewMax).

max(A, B, C) when A >= B andalso A >= C -> A;
max(A, B, C) when B >= A andalso B >= C -> B;
max(_, _, C) -> C.