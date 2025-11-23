-module(even_digits).
-export([find_numbers/1]).

find_numbers(Nums) ->
    lists:foldl(fun(Num, Acc) ->
        case length(integer_to_list(Num)) rem 2 of
            0 -> Acc + 1;
            _ -> Acc
        end
    end, 0, Nums).