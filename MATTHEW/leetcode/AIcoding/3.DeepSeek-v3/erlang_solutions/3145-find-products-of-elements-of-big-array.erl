-module(solution).
-export([product_of_big_array/1]).

product_of_big_array(Nums) ->
    lists:map(fun(N) -> product(N) end, Nums).

product(N) ->
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            case N rem 2 of
                0 -> (product(N div 2) * 2;
                1 -> product(N div 2)
            end
    end.