-spec count_pairs(Nums :: [integer()], K :: integer()) -> integer().
count_pairs(Nums, K) ->
    Indices = lists:zip(lists:seq(0, length(Nums) - 1), Nums),
    Pairs = [ {I, J} || {I, X} <- Indices, {J, Y} <- Indices, I < J, X =:= Y, (I * J) rem K =:= 0 ],
    length(Pairs).