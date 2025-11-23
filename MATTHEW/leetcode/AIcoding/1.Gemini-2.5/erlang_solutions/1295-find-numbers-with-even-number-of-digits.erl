-spec find_numbers(Nums :: [integer()]) -> integer().
find_numbers(Nums) ->
    lists:foldl(fun(Num, Acc) ->
                    Digits = length(integer_to_list(Num)),
                    case Digits rem 2 of
                        0 -> Acc + 1;
                        _ -> Acc
                    end
                end, 0, Nums).