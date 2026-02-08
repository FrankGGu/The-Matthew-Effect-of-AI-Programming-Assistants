-module(num_same_consec_diff).
-export([nums_same_consec_diff/2]).

nums_same_consec_diff(N, K) ->
    Results = lists:foldl(fun(Digit, Acc) ->
        if
            Digit == 0 -> Acc;
            true -> lists:append(Acc, dfs(Digit, N - 1, K, Digit))
        end
    end, [], lists:seq(1, 9)),
    lists:sort(Results).

dfs(Current, 1, _, _) ->
    [Current];
dfs(Current, Length, K, Start) ->
    lists:foldl(fun(Digit, Acc) ->
        if
            abs(Digit - Current) == K ->
                lists:append(Acc, dfs(Digit, Length - 1, K, Start));
            true -> Acc
        end
    end, [], lists:seq(0, 9)).