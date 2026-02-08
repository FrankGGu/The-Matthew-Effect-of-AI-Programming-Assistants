-module(combinationsumiii).
-export([combination_sum_iii/2]).

combination_sum_iii(K, N) ->
    combination_sum_iii(K, N, 1, [], []).

combination_sum_iii(_, _, _, Acc, Result) when length(Acc) == K andalso lists:sum(Acc) == N ->
    [lists:reverse(Acc) | Result];
combination_sum_iii(_, _, _, Acc, Result) when length(Acc) == K ->
    Result;
combination_sum_iii(_, _, Num, Acc, Result) when Num > 9 ->
    Result;
combination_sum_iii(K, N, Num, Acc, Result) ->
    if
        lists:sum([Num | Acc]) + Num > N ->
            combination_sum_iii(K, N, Num + 1, Acc, Result);
        true ->
            combination_sum_iii(K, N, Num + 1, [Num | Acc], 
                combination_sum_iii(K, N, Num + 1, Acc, Result))
    end.