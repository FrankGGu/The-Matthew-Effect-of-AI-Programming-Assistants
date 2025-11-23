-spec combination_sum2(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum2(Candidates, Target) ->
    Sorted = lists:sort(Candidates),
    dfs(Sorted, Target, 0, [], []).

dfs([], 0, _, Path, Acc) ->
    [Path | Acc];
dfs([], _, _, _, Acc) ->
    Acc;
dfs([H | T], Target, Index, Path, Acc) ->
    case H > Target of
        true -> Acc;
        false ->
            NewAcc = case Index =:= 0 orelse H =/= lists:nth(Index, lists:reverse(Path)) of
                true ->
                    dfs(T, Target - H, Index + 1, [H | Path], Acc);
                false ->
                    Acc
            end,
            dfs(T, Target, Index + 1, Path, NewAcc)
    end.