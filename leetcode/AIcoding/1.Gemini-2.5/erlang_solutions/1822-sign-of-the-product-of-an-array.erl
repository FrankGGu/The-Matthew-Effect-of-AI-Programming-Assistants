-module(solution).
-export([arraySign/1]).

arraySign(Nums) ->
    sign_product_accumulator(Nums, 0).

sign_product_accumulator([], NegCount) ->
    case NegCount rem 2 of
        0 -> 1;
        _ -> -1
    end;
sign_product_accumulator([H|T], NegCount) ->
    if
        H == 0 -> 0;
        H < 0 -> sign_product_accumulator(T, NegCount + 1);
        true -> sign_product_accumulator(T, NegCount)
    end.