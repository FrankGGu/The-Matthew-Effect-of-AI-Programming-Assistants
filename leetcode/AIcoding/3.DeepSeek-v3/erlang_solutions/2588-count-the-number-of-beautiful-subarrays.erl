-spec beautiful_subarrays(Nums :: [integer()]) -> integer().
beautiful_subarrays(Nums) ->
    PrefixXor = 0,
    Count = #{0 => 1},
    lists:foldl(fun(Num, {AccXor, AccCount, Res}) ->
        NewXor = AccXor bxor Num,
        case maps:get(NewXor, AccCount, 0) of
            Val when is_integer(Val) -> 
                NewRes = Res + Val,
                NewCount = maps:put(NewXor, Val + 1, AccCount),
                {NewXor, NewCount, NewRes}
        end
    end, {PrefixXor, Count, 0}, Nums).