%% -spec num_array_init_(Nums :: [integer()]) -> any().
num_array_init_(Nums) ->
    lists:foldl(fun(X, Acc) -> [X | Acc] end, [], Nums).

%% -spec num_array_sum_range(Left :: integer(), Right :: integer(), Nums :: [integer()]) -> integer().
num_array_sum_range(Left, Right, Nums) ->
    lists:sum(lists:sublist(Nums, Left + 1, Right - Left + 1)).
