-module(solution).
-export([maximumJumps/2]).

maximumJumps(Nums, Target) ->
    N = length(Nums),
    if N == 1 ->
        0;
    true ->
        NumsArray = array:from_list(Nums),

        DP = array:new([{size, N}, {default, -1}]),
        DP0 = array:set(0, 0, DP),

        ResultDP = lists:foldl(fun(I, CurrentDP) ->
            lists:foldl(fun(J, InnerDP) ->
                JumpsToJ = array:get(J, InnerDP),
                if JumpsToJ /= -1 ->
                    NumJ = array:get(J, NumsArray),
                    NumI = array:get(I, NumsArray),
                    AbsDiff = abs(NumJ - NumI),
                    if AbsDiff =< Target ->
                        CurrentMaxJumpsToI = array:get(I, InnerDP),
                        array:set(I, max(CurrentMaxJumpsToI, JumpsToJ + 1), InnerDP);
                    true ->
                        InnerDP
                    end;
                true ->
                    InnerDP
                end
            end, CurrentDP, lists:seq(0, I-1))
        end, DP0, lists:seq(1, N-1)),

        array:get(N-1, ResultDP)
    end.