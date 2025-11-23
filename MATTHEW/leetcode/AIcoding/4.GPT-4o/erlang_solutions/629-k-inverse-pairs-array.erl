-module(solution).
-export([k_inverse_pairs/2]).

k_inverse_pairs(N, K) ->
    M = 10^9 + 7,
    DP = lists:duplicate(K + 1, lists:duplicate(N + 1, 0)),
    DP[0][0] = 1,
    lists:foldl(fun(_, Acc) ->
        lists:foldl(fun(K1, Acc1) ->
            lists:foldl(fun(X, Acc2) ->
                NewK = K1 - X,
                if
                    NewK >= 0 -> 
                        {1, 0} = lists:foldl(fun(P, {S, C}) -> 
                            {C + (Acc1[P] mod M), C + S} 
                        end, {0, 0}, lists:seq(0, X)),
                        Acc2 + (Acc1[NewK] mod M)
                    true -> 
                        Acc2
                end
            end, Acc1, lists:seq(0, N)),
            Acc1
        end, Acc, lists:seq(1, K))
    end, DP, lists:seq(1, N)),
    lists:last(lists:last(DP)).