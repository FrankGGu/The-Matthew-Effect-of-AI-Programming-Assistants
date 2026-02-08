-module(max_xor_product).
-export([max_xor_product/2]).

max_xor_product(A, B) ->
    max_xor_product(A, B, 0).

max_xor_product(A, B, Acc) when A >= 0, B >= 0 ->
    case A band B of
        0 -> (A bor B) * (A band B);
        _ -> 
            if
                (A + 1) * (B - 1) > (A - 1) * (B + 1) ->
                    max_xor_product(A + 1, B - 1, Acc + 1);
                true ->
                    max_xor_product(A - 1, B + 1, Acc + 1)
            end
    end;
max_xor_product(_, _, _) ->
    0.