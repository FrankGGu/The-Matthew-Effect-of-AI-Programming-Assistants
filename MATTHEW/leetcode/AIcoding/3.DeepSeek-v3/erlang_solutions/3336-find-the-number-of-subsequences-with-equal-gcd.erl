-module(solution).
-export([count_subsequences/1]).

count_subsequences(Nums) ->
    Max = lists:max(Nums),
    Counts = lists:foldl(fun(X, Acc) -> 
                            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Nums),
    DP = maps:new(),
    DP1 = lists:foldl(fun(I, Acc) ->
                        case maps:is_key(I, Counts) of
                            true ->
                                maps:put(I, maps:get(I, Counts), Acc);
                            false ->
                                Acc
                        end
                      end, DP, lists:seq(1, Max)),
    Result = lists:foldl(fun(I, Sum) ->
                            case maps:is_key(I, DP1) of
                                true ->
                                    Cnt = maps:get(I, DP1),
                                    Total = (Cnt * (Cnt + 1)) div 2,
                                    J = 2 * I,
                                    DP2 = update_dp(DP1, I, J, Max),
                                    Sum + Total + count_gcd(DP2, I, J, Max);
                                false ->
                                    Sum
                            end
                         end, 0, lists:seq(1, Max)),
    Result.

update_dp(DP, I, J, Max) when J =< Max ->
    case maps:is_key(J, DP) of
        true ->
            CntJ = maps:get(J, DP),
            CntI = maps:get(I, DP),
            NewDP = maps:put(J, CntJ - CntI, DP),
            update_dp(NewDP, I, J + I, Max);
        false ->
            update_dp(DP, I, J + I, Max)
    end;
update_dp(DP, _, _, _) ->
    DP.

count_gcd(DP, I, J, Max) when J =< Max ->
    case maps:is_key(J, DP) of
        true ->
            Cnt = maps:get(J, DP),
            Total = (Cnt * (Cnt + 1)) div 2,
            DP1 = update_dp(DP, I, J + I, Max),
            Total + count_gcd(DP1, I, J + I, Max);
        false ->
            count_gcd(DP, I, J + I, Max)
    end;
count_gcd(_, _, _, _) ->
    0.