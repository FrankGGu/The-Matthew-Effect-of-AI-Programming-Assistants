-spec min_cost(Nums :: [integer()], X :: integer()) -> integer().
min_cost(Nums, X) ->
    N = length(Nums),
    DP = lists:duplicate(N, 0),
    lists:min(lists:map(fun(I) -> solve(Nums, X, I, N, DP) end, lists:seq(0, N - 1))).

solve(Nums, X, I, N, DP) ->
    case I of
        0 -> lists:nth(1, Nums);
        _ ->
            case lists:nth(I + 1, DP) of
                0 ->
                    Min = lists:min([lists:nth(J + 1, Nums) | 
                                    [solve(Nums, X, (I - K) rem N, N, DP) + X * K || 
                                    K <- lists:seq(1, I)]]),
                    lists:sublist(DP, I, 1, [Min]),
                    Min;
                Val -> Val
            end
    end.