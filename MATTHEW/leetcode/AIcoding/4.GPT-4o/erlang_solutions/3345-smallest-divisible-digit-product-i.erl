-module(smallest_divisible_digit_product).
-export([smallest_divisible_digit_product/1]).

smallest_divisible_digit_product(N) ->
    lists:foldl(fun(Digit, Acc) -> 
        if 
            Acc rem Digit =:= 0 -> 
                Acc;
            true -> 
                Acc + Digit 
        end 
    end, N, [1,2,3,4,5,6,7,8,9]).