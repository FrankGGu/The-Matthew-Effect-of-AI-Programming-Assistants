-spec min_capability(Nums :: [integer()], K :: integer()) -> integer().
min_capability(Nums, K) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    binary_search(Nums, K, Min, Max).

binary_search(Nums, K, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case can_rob(Nums, K, Mid) of
        true -> binary_search(Nums, K, Left, Mid);
        false -> binary_search(Nums, K, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) -> Left.

can_rob(Nums, K, Cap) ->
    {Count, _} = lists:foldl(fun(N, {Cnt, PrevRobbed}) ->
        case N =< Cap of
            true when not PrevRobbed -> {Cnt + 1, true};
            _ -> {Cnt, false}
        end
    end, {0, false}, Nums),
    Count >= K.