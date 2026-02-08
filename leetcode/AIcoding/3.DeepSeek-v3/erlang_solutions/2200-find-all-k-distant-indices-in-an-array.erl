-spec find_k_distant_indices(Nums :: [integer()], Key :: integer(), K :: integer()) -> [integer()].
find_k_distant_indices(Nums, Key, K) ->
    Indices = [I || {I, X} <- lists:zip(lists:seq(0, length(Nums) - 1), Nums), X =:= Key],
    AllIndices = lists:seq(0, length(Nums) - 1),
    lists:usort(lists:flatten([[J || J <- AllIndices, abs(J - I) =< K] || I <- Indices])).