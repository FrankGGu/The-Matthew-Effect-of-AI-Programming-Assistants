-spec find_non_min_or_max([integer()]) -> integer().
find_non_min_or_max(Nums) ->
    case length(Nums) =< 2 of
        true -> -1;
        false ->
            Min = lists:min(Nums),
            Max = lists:max(Nums),
            case lists:filter(fun(X) -> X =/= Min andalso X =/= Max end, nums) of
                [] -> -1;
                [H | _] -> H
            end
    end.