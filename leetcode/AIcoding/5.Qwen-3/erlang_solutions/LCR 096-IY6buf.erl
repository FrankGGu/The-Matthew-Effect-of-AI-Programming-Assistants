-module(solution).
-export([is_interleave/3]).

is_interleave(S1, S2, S3) ->
    N = length(S1),
    M = length(S2),
    K = length(S3),
    if
        N + M =/= K -> false;
        true ->
            DP = array:new([{size, N+1}, {default, array:new([{size, M+1}, {default, false}])}]),
            array:set(0, 0, true, DP),
            I = 0,
            loop_i(I, N, S1, S2, S3, DP)
    end.

loop_i(I, N, S1, S2, S3, DP) when I =< N ->
    J = 0,
    loop_j(J, M, S1, S2, S3, I, DP),
    loop_i(I+1, N, S1, S2, S3, DP);
loop_i(_, _, _, _, _, DP) ->
    array:get(0, 0, DP).

loop_j(J, M, S1, S2, S3, I, DP) when J =< M ->
    case I of
        0 ->
            case J of
                0 -> ok;
                _ -> 
                    Prev = array:get(0, J-1, DP),
                    CurrentChar = lists:nth(J, S3),
                    TargetChar = lists:nth(J, S2),
                    if
                        Prev and (CurrentChar == TargetChar) -> array:set(0, J, true, DP);
                        true -> DP
                    end
            end;
        _ ->
            case J of
                0 ->
                    Prev = array:get(I-1, 0, DP),
                    CurrentChar = lists:nth(I, S3),
                    TargetChar = lists:nth(I, S1),
                    if
                        Prev and (CurrentChar == TargetChar) -> array:set(I, 0, true, DP);
                        true -> DP
                    end;
                _ ->
                    Prev1 = array:get(I-1, J, DP),
                    CurrentChar = lists:nth(I+J, S3),
                    TargetChar1 = lists:nth(I, S1),
                    Cond1 = Prev1 and (CurrentChar == TargetChar1),
                    Prev2 = array:get(I, J-1, DP),
                    TargetChar2 = lists:nth(J, S2),
                    Cond2 = Prev2 and (CurrentChar == TargetChar2),
                    if
                        Cond1 or Cond2 -> array:set(I, J, true, DP);
                        true -> DP
                    end
            end
    end,
    loop_j(J+1, M, S1, S2, S3, I, DP);
loop_j(_, _, _, _, _, _, DP) ->
    DP.