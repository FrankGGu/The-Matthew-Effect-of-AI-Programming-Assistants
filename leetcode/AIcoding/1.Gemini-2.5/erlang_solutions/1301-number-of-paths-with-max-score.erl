-module(solution).
-export([pathsWithMaxScore/1]).

get_char_val($E) -> 0;
get_char_val($S) -> 0;
get_char_val(Char) when Char >= $0, Char <= $9 -> Char - $0.

init_dp_table(N) ->
    lists:foldl(fun(R, Acc) ->
                    array:set(R, array:new([{size, N}, {default, {-1, 0}}]), Acc)
                end,
                array:new([{size, N}]),
                lists:seq(0, N-1)).

get_dp(R, C, DP_table) ->
    array:get(C, array:get(R, DP_table)).

set_dp(R, C, Value, DP_table) ->
    Row = array:get(R, DP_table),
    NewRow = array:set(C, Value, Row),
    array:set(R, NewRow, DP_table).

pathsWithMaxScore(Board) ->
    N = length(Board),
    Mod = 1000000007,

    DP_table = init_dp_table(N),

    DP_final = set_dp(N-1, N-1, {0, 1}, DP_table),

    FinalDP =
        lists:foldl(fun(R, CurrentDP) ->
                        BoardRow = lists:nth(R+1, Board),
                        lists:foldl(fun(C, InnerCurrentDP) ->
                                        if
                                            R == N-1 andalso C == N-1 ->
                                                InnerCurrentDP;
                                            true ->
                                                Char = lists:nth(C+1, BoardRow),
                                                if
                                                    Char == $X ->
                                                        InnerCurrentDP;
                                                    true ->
                                                        CurrentVal = get_char_val(Char),

                                                        Candidates = [],
                                                        Candidates1 =
                                                            if R+1 < N ->
                                                                {S_up, C_up} = get_dp(R+1, C, InnerCurrentDP),
                                                                if S_up >= 0 -> [{S_up, C_up}]; true -> [] end
                                                            ; true -> []
                                                            end,
                                                        Candidates2 =
                                                            if C+1 < N ->
                                                                {S_left, C_left} = get_dp(R, C+1, InnerCurrentDP),
                                                                if S_left >= 0 -> [{S_left, C_left}]; true -> [] end
                                                            ; true -> []
                                                            end,
                                                        Candidates3 =
                                                            if R+1 < N andalso C+1 < N ->
                                                                {S_diag, C_diag} = get_dp(R+1, C+1, InnerCurrentDP),
                                                                if S_diag >= 0 -> [{S_diag, C_diag}]; true -> [] end
                                                            ; true -> []
                                                            end,

                                                        AllCandidates = Candidates1 ++ Candidates2 ++ Candidates3,

                                                        if
                                                            AllCandidates == [] ->
                                                                set_dp(R, C, {-1, 0}, InnerCurrentDP);
                                                            true ->
                                                                MaxScoreFromNeighbors =
                                                                    lists:foldl(fun({S, _}, Max) -> max(Max, S) end, -1, AllCandidates),

                                                                NumPathsToMaxScore =
                                                                    lists:foldl(fun({S, C_path}, Acc) ->
                                                                                        if S == MaxScoreFromNeighbors ->
                                                                                            (Acc + C_path) rem Mod;
                                                                                        true ->
                                                                                            Acc
                                                                                        end
                                                                                end, 0, AllCandidates),

                                                                set_dp(R, C, {MaxScoreFromNeighbors + CurrentVal, NumPathsToMaxScore}, InnerCurrentDP)
                                                        end
                                                end
                                        end
                                    end, InnerCurrentDP, lists:seq(N-1, 0, -1))
                    end, DP_final, lists:seq(N-1, 0, -1)),

    Result = get_dp(0, 0, FinalDP),

    if
        Result == {-1, 0} -> [0, 0];
        Result == {0, 1} andalso lists:nth(1, lists:nth(1, Board)) == $S -> [0, 0];
        true -> [element(1, Result), element(2, Result)]
    end.