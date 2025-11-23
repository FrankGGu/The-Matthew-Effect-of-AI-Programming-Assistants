-spec largest_almost_missing_integer(Nums :: [integer()]) -> integer().
largest_almost_missing_integer(Nums) ->
    UniqueNums = lists:usort(Nums),
    AllPossible = lists:usort([X + 1 || X <- UniqueNums] ++ [X - 1 || X <- UniqueNums]),
    Missing = [X || X <- AllPossible, not lists:member(X, UniqueNums)],
    case Missing of
        [] -> -1;
        _ -> lists:max(Missing)
    end.