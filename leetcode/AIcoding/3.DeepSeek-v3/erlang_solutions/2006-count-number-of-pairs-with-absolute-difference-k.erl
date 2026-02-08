-spec count_k_difference(Nums :: [integer()], K :: integer()) -> integer().
count_k_difference(Nums, K) ->
    lists:foldl(fun(_, Acc) -> Acc end, 0, 
        [begin
            lists:foldl(fun(Y, Acc1) -> 
                if abs(X - Y) =:= K -> Acc1 + 1; true -> Acc1 end
            end, 0, Nums)
        end || X <- Nums]).