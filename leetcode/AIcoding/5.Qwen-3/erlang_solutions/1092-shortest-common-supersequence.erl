-module(scs).
-export([shortest_common_supersequence/2]).

shortest_common_supersequence(S1, S2) ->
    Lcs = longest_common_subsequence(S1, S2),
    build_scs(S1, S2, Lcs, [], 0, 0, 0).

longest_common_subsequence(S1, S2) ->
    N = length(S1),
    M = length(S2),
    DP = array:new([{size, N+1}, {default, array:new(M+1)}]),
    lists:foreach(fun(I) -> 
        array:set(I, 0, array:get(I, DP))
    end, lists:seq(1, N)),
    lists:foreach(fun(J) -> 
        array:set(0, J, 0, array:get(0, DP))
    end, lists:seq(1, M)),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                lists:nth(I, S1) == lists:nth(J, S2) ->
                    Val = array:get(I-1, J-1, array:get(I-1, DP)) + 1,
                    array:set(I, J, Val, array:get(I, DP));
                true ->
                    Val = max(array:get(I-1, J, array:get(I-1, DP)), array:get(I, J-1, array:get(I, DP))),
                    array:set(I, J, Val, array:get(I, DP))
            end
        end, lists:seq(1, M))
    end, lists:seq(1, N)),
    LCS = [],
    I = N,
    J = M,
    while I > 0 andalso J > 0 do
        if
            lists:nth(I, S1) == lists:nth(J, S2) ->
                LCS = [lists:nth(I, S1) | LCS],
                I = I - 1,
                J = J - 1;
            true ->
                if
                    array:get(I-1, J, array:get(I-1, DP)) >= array:get(I, J-1, array:get(I, DP)) ->
                        I = I - 1;
                    true ->
                        J = J - 1
                end
        end
    end,
    LCS.

build_scs(_, _, [], Acc, _, _, _) ->
    lists:reverse(Acc);
build_scs(S1, S2, [H|T], Acc, I, J, K) ->
    while I < length(S1) andalso lists:nth(I+1, S1) /= H do
        Acc = [lists:nth(I+1, S1) | Acc],
        I = I + 1
    end,
    while J < length(S2) andalso lists:nth(J+1, S2) /= H do
        Acc = [lists:nth(J+1, S2) | Acc],
        J = J + 1
    end,
    Acc = [H | Acc],
    I = I + 1,
    J = J + 1,
    build_scs(S1, S2, T, Acc, I, J, K).