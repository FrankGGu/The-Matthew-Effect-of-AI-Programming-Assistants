-module(maximum_subarray_with_equal_products).
-export([maxSubarray/1]).

maxSubarray(Nums) ->
    maxSubarray(Nums, 0, 0, 1, 0).

maxSubarray([], _, _, _, Max) ->
    Max;
maxSubarray([N | Rest], Start, End, Product, Max) ->
    case N of
        0 ->
            if
                Product /= 0 ->
                    NewMax = max(Max, End - Start + 1),
                    maxSubarray(Rest, End + 1, End + 1, 1, NewMax);
                true ->
                    maxSubarray(Rest, End + 1, End + 1, 1, Max)
            end;
        _ ->
            NewProduct = Product * N,
            if
                NewProduct == 0 ->
                    NewMax = max(Max, End - Start + 1),
                    maxSubarray(Rest, End + 1, End + 1, 1, NewMax);
                true ->
                    maxSubarray(Rest, Start, End + 1, NewProduct, Max)
            end
    end.