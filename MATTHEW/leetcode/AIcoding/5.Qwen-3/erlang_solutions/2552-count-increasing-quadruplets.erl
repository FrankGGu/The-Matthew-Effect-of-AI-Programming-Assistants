-module(solution).
-export([count_increasing_quadruplets/1]).

count_increasing_quadruplets(A) ->
    N = length(A),
    Count = 0,
    count_increasing_quadruplets(A, N, Count).

count_increasing_quadruplets(_, _, Count) when Count >= 1000000007 ->
    Count rem 1000000007;
count_increasing_quadruplets(A, N, Count) ->
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if J > I ->
                lists:foldl(fun(K, Acc3) ->
                    if K > J ->
                        lists:foldl(fun(L, Acc4) ->
                            if L > K ->
                                Acc4 + 1;
                            true ->
                                Acc4
                            end
                        end, Acc3, lists:seq(K+1, N-1));
                    true ->
                        Acc3
                    end
                end, Acc2, lists:seq(J+1, N-1));
            true ->
                Acc2
            end
        end, Acc, lists:seq(0, I-1))
    end, Count, lists:seq(0, N-1)).