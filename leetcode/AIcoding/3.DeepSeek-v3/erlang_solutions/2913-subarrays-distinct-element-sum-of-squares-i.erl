-spec sum_counts(Nums :: [integer()]) -> integer().
sum_counts(Nums) ->
    Length = length(Nums),
    lists:sum([length(lists:usort(lists:sublist(Nums, I, J))) * length(lists:usort(lists:sublist(Nums, I, J))) 
               || I <- lists:seq(1, Length), J <- lists:seq(1, Length - I + 1)]).