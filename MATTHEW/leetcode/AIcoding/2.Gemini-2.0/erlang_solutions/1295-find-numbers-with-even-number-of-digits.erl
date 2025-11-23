-module(find_numbers_with_even_digits).
-export([find_numbers/1]).

find_numbers(Nums) ->
    lists:foldl(fun(Num, Acc) ->
                        Len = length(integer_to_list(Num)),
                        if
                            Len rem 2 == 0 ->
                                Acc + 1;
                            true ->
                                Acc
                        end
                    end, 0, Nums).