-spec contains_duplicate(Nums :: [integer()]) -> boolean().
contains_duplicate(Nums) ->
    case lists:usort(Nums) == Nums of
        true -> false;
        false -> true
    end.
