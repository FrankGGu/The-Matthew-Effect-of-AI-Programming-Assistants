-spec subset_xor_sum(Nums :: [integer()]) -> integer().
subset_xor_sum(Nums) ->
    Subsets = subsets(Nums),
    lists:sum([xor_list(Subset) || Subset <- Subsets]).

subsets([]) -> [[]];
subsets([H|T]) ->
    Subsets = subsets(T),
    Subsets ++ [[H|Subset] || Subset <- Subsets].

xor_list([]) -> 0;
xor_list([H|T]) -> H bxor xor_list(T).