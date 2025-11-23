-spec create_target_array(Nums :: [integer()], Index :: [integer()]) -> [integer()].
create_target_array(Nums, Index) ->
    lists:foldl(fun({Num, Idx}, Acc) ->
        {Left, Right} = lists:split(Idx, Acc),
        Left ++ [Num] ++ Right
    end, [], lists:zip(Nums, Index)).