-module(largest_sum_of_averages).
-export([largest_sum_of_averages/2]).

largest_sum_of_averages(aa, k) ->
    N = length(aa),
    Sums = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], aa),
    Sums1 = lists:reverse(Sums),
    Averages = lists:map(fun(X) -> X / 1 end, Sums1),
    dp(N, k, Averages).

dp(N, K, Averages) when K > 0, N >= K ->
    dp_helper(N, K, Averages, lists:duplicate(K + 1, -1)).

dp_helper(N, K, Averages, Memo) ->
    case Memo of
        [] -> 0;
        _ ->
            case lists:nth(N, Memo) of
                -1 ->
                    Max = lists:max([avg(N, j, Averages) + dp_helper(j, K - 1, Averages, Memo) || j <- lists:seq(K - 1, N - 1)]),
                    Memo1 = lists:replace(N, Max, Memo),
                    Max;
                Val -> Val
            end
    end.

avg(I, J, Averages) ->
    sum(Averages, I, J) / (J - I + 1).

sum(Averages, I, J) ->
    lists:sum(lists:sublist(Averages, I + 1, J - I + 1)).