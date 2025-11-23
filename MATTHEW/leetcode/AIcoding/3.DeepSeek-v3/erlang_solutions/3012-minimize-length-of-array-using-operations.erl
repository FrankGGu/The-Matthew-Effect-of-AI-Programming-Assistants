-spec minimize_array_length(Nums :: [integer()]) -> integer().
minimize_array_length(Nums) ->
    sets:size(sets:from_list(Nums)).