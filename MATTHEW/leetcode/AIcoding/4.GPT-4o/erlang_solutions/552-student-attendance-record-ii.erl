-module(solution).
-export([checkRecord/1]).

checkRecord(N) ->
    %% Calculate the number of valid attendance records using dynamic programming
    Mod = 1000000007,
    % dp[i][j][k]: the number of valid records of length i with j A's and k consecutive L's
    % We will have 0 <= j <= 1 (only one A allowed) and 0 <= k <= 2 (only two consecutive L's allowed)
    dp = lists:foldl(fun(_, Acc) -> 
        lists:map(fun({j, k}) -> 
            {j, k + 1} 
        end, Acc) ++ 
        lists:map(fun({j, k}) -> 
            {j + 1, 0} 
        end, Acc) ++ 
        lists:map(fun({j, k}) -> 
            {j, 0} 
        end, Acc)
    end, [{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 1}, {1, 2}], lists:seq(1, N)),
    lists:foldl(fun({j, k}, Acc) -> 
        (Acc + dp_to_sum(j, k, Mod)) rem Mod 
    end, 0, dp).

dp_to_sum(J, K, Mod) ->
    case {J, K} of
        {0, 0} -> 1;
        {0, 1} -> 1;
        {0, 2} -> 1;
        {1, 0} -> 1;
        {1, 1} -> 1;
        {1, 2} -> 1;
        _ -> 0
    end.