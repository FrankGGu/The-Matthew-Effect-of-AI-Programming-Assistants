-spec min_impossible_or(Nums :: [integer()]) -> integer().
min_impossible_or(Nums) ->
    S = sets:from_list(Nums),
    find_min(S, 1).

find_min(S, X) ->
    case sets:is_element(X, S) of
        true -> find_min(S, X bsl 1);
        false -> X
    end.