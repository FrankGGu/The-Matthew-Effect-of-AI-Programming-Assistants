-spec digit_difference_sum(Nums :: [integer()]) -> integer().
digit_difference_sum(Nums) ->
    Counts = lists:foldl(fun(Num, Acc) ->
        Digits = integer_to_list(Num),
        lists:foldl(fun({D, Pos}, AccIn) ->
            Key = {Pos, D},
            maps:update_with(Key, fun(V) -> V + 1 end, 1, AccIn)
        end, Acc, lists:zip(Digits, lists:seq(1, length(Digits))))
    end, #{}, Nums),
    lists:foldl(fun({_, D}, Sum) ->
        Sum + D * (length(Nums) - D)
    end, 0, maps:to_list(Counts)) div 2.