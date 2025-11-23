-module(solution).
-export([paths_with_max_score/1]).

paths_with_max_score(Board) ->
    M = length(Board),
    N = length(hd(Board)),
    DP = lists:duplicate(M, lists:duplicate(N, {0, 0})),
    {MaxScore, Count} = dfs(Board, DP, M - 1, N - 1),
    [MaxScore, Count].

dfs(Board, DP, I, J) ->
    case I =:= 0 andalso J =:= 0 of
        true -> {0, 1};
        false ->
            case lists:nth(I + 1, lists:nth(J + 1, DP)) of
                {-1, 0} -> {-1, 0};
                {Score, Count} when Score =/= -1 -> {Score, Count};
                _ ->
                    Current = lists:nth(I + 1, lists:nth(J + 1, Board)),
                    case Current of
                        $X -> {-1, 0};
                        _ ->
                            Candidates = [],
                            if
                                I > 0 andalso J > 0 ->
                                    {S1, C1} = dfs(Board, DP, I - 1, J - 1),
                                    Candidates1 = if S1 =/= -1 -> [{S1, C1} | Candidates]; true -> Candidates end,
                                    {S2, C2} = dfs(Board, DP, I - 1, J),
                                    Candidates2 = if S2 =/= -1 -> [{S2, C2} | Candidates1]; true -> Candidates1 end,
                                    {S3, C3} = dfs(Board, DP, I, J - 1),
                                    Candidates3 = if S3 =/= -1 -> [{S3, C3} | Candidates2]; true -> Candidates2 end,
                                    Candidates3;
                                I > 0 ->
                                    {S2, C2} = dfs(Board, DP, I - 1, J),
                                    Candidates2 = if S2 =/= -1 -> [{S2, C2} | Candidates]; true -> Candidates end,
                                    Candidates2;
                                J > 0 ->
                                    {S3, C3} = dfs(Board, DP, I, J - 1),
                                    Candidates3 = if S3 =/= -1 -> [{S3, C3} | Candidates]; true -> Candidates end,
                                    Candidates3;
                                true -> []
                            end,
                            case Candidates of
                                [] -> {-1, 0};
                                _ ->
                                    MaxScore = lists:max(lists:map(fun({S, _}) -> S end, Candidates)),
                                    Filtered = lists:filter(fun({S, _}) -> S =:= MaxScore end, Candidates),
                                    TotalCount = lists:sum(lists:map(fun({_, C}) -> C end, Filtered)),
                                    CurrentScore = if Current >= $1 andalso Current =< $9 -> Current - $0; true -> 0 end,
                                    NewScore = if MaxScore =:= -1 -> -1; true -> MaxScore + CurrentScore end,
                                    NewCount = if MaxScore =:= -1 -> 0; true -> TotalCount end,
                                    DP1 = set_dp(DP, I + 1, J + 1, {NewScore, NewCount}),
                                    {NewScore, NewCount}
                            end
                    end
            end
    end.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I, DP),
    NewRow = setelement(J, list_to_tuple(Row), Val),
    setelement(I, list_to_tuple(DP), tuple_to_list(NewRow)).