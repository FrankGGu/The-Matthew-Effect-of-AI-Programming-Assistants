-module(interleaving_string).
-export([is_interleave/3]).

is_interleave(A, B, C) ->
    N = length(A),
    M = length(B),
    K = length(C),
    if
        K =/= N + M -> false;
        true ->
            DP = array:new([{size, N+1}, {default, array:new([{size, M+1}, {default, false}])}]),
            array:set(0, 0, true, DP),
            lists:foreach(fun(I) -> array:set(0, I, true, DP) end, lists:seq(0, min(M, K))),
            lists:foreach(fun(J) -> array:set(J, 0, true, DP) end, lists:seq(0, min(N, K))),
            lists:foreach(fun(I) ->
                lists:foreach(fun(J) ->
                    KI = I + J,
                    if
                        KI < K ->
                            AChar = lists:nth(I+1, A),
                            BChar = lists:nth(J+1, B),
                            CChar = lists:nth(KI+1, C),
                            Case1 = array:get(I-1, J, DP) and (AChar == CChar),
                            Case2 = array:get(I, J-1, DP) and (BChar == CChar),
                            array:set(I, J, Case1 or Case2, DP);
                        true -> ok
                    end
                end, lists:seq(0, M))
            end, lists:seq(0, N)),
            array:get(N, M, DP)
    end.