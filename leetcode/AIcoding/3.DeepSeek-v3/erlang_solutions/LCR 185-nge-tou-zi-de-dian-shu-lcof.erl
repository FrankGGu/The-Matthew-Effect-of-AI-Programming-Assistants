-module(solution).
-export([dicesProbability/1]).

dicesProbability(N) ->
    DP = lists:duplicate(6 * N + 1, 0),
    DP1 = lists:sublist(DP, 1, 6 * N + 1),
    DP2 = lists:duplicate(6 * N + 1, 0),
    DP3 = lists:sublist(DP2, 1, 6 * N + 1),
    lists:foldl(fun(_, {DPPrev, DPNext}) ->
        lists:foldl(fun(J, DPAcc) ->
            lists:foldl(fun(K, DPAcc2) ->
                case K >= J andalso K - J >= 1 andalso K - J =< 6 of
                    true -> 
                        Val = lists:nth(J, DPPrev) + lists:nth(K - J, DPAcc),
                        lists:sublist(DPAcc2, 1, J - 1) ++ [Val] ++ lists:sublist(DPAcc2, J + 1, length(DPAcc2) - J);
                    false -> DPAcc2
                end
            end, DPAcc, lists:seq(1, 6 * N))
        end, DPNext, lists:seq(1, 6 * N))
    end, {DP1, DP3}, lists:seq(1, N - 1)),
    {_, FinalDP} = lists:foldl(fun(I, {DPPrev, DPNext}) ->
        lists:foldl(fun(J, DPAcc) ->
            lists:foldl(fun(K, DPAcc2) ->
                case K >= J andalso K - J >= 1 andalso K - J =< 6 of
                    true -> 
                        Val = lists:nth(J, DPPrev) + lists:nth(K - J, DPAcc),
                        lists:sublist(DPAcc2, 1, J - 1) ++ [Val] ++ lists:sublist(DPAcc2, J + 1, length(DPAcc2) - J);
                    false -> DPAcc2
                end
            end, DPAcc, lists:seq(1, 6 * N))
        end, DPNext, lists:seq(1, 6 * N)),
        {DPNext, DPNext}
    end, {DP1, DP3}, lists:seq(1, N - 1)),
    Total = math:pow(6, N),
    lists:map(fun(X) -> X / Total end, lists:sublist(FinalDP, N, 6 * N - N + 1)).