-spec max_score(Nums :: [integer()], X :: integer()) -> integer().
max_score(Nums, X) ->
    N = length(Nums),
    DP = array:new([{size, N}, {default, -1}]),
    lists:max([dfs(Nums, X, DP, I, Nums rem 2) || I <- lists:seq(1, N)]).

dfs(Nums, X, DP, I, Parity) ->
    case I =< 0 of
        true -> 0;
        false ->
            case array:get(I - 1, DP) of
                -1 ->
                    Current = lists:nth(I, Nums),
                    CurrentParity = Current rem 2,
                    Max = lists:max([
                        Current + dfs(Nums, X, DP, J, CurrentParity) ||
                        J <- lists:seq(1, I - 1),
                        (lists:nth(J, Nums) rem 2) =/= CurrentParity
                    ] ++ [
                        Current + dfs(Nums, X, DP, J, CurrentParity) - X ||
                        J <- lists:seq(1, I - 1),
                        (lists:nth(J, Nums) rem 2) =:= CurrentParity
                    ] ++ [Current]),
                    array:set(I - 1, Max, DP),
                    Max;
                Val -> Val
            end
    end.