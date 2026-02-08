-module(lcs).
-export([longest_common_subsequence/2]).

longest_common_subsequence(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new([{size, N+1}, {default, 0}]),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if I == 0 -> array:set(I* (M+1) + J, 0, DP);
               J == 0 -> array:set(I* (M+1) + J, 0, DP);
               true -> 
                    if lists:nth(I, A) == lists:nth(J, B) -> 
                        Val = array:get((I-1)*(M+1) + (J-1), DP) + 1,
                        array:set(I*(M+1) + J, Val, DP);
                       true -> 
                        Val1 = array:get((I-1)*(M+1) + J, DP),
                        Val2 = array:get(I*(M+1) + (J-1), DP),
                        Max = max(Val1, Val2),
                        array:set(I*(M+1) + J, Max, DP)
                    end
            end
        end, lists:seq(1, M))
    end, lists:seq(1, N)),
    array:get(N*(M+1) + M, DP).