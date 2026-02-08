-spec contains_duplicate(Nums :: [integer()]) -> boolean().
contains_duplicate(Nums) ->
    Set = sets:from_list(Nums),
    sets:size(Set) =/= length(Nums).