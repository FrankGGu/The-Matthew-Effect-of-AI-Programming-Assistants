-spec min_operations(Nums :: [integer()], K :: integer()) -> integer().
min_operations(Nums, K) ->
    case K =:= 1 of
        true -> 0;
        false ->
            lists:min([begin
                Sub = lists:sublist(Nums, I, K),
                Target = lists:nth((K div 2) + 1, lists:sort(Sub)),
                lists:sum([abs(X - Target) || X <- Sub])
            end || I <- lists:seq(1, length(Nums) - K + 1)])
    end.