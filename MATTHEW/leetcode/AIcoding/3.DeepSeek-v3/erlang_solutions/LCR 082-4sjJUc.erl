-spec combination_sum2(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum2(Candidates, Target) ->
    Sorted = lists:sort(Candidates),
    dfs(Sorted, Target, 0, [], []).

dfs(_, 0, _, Path, Acc) ->
    [Path | Acc];
dfs([], _, _, _, Acc) ->
    Acc;
dfs([H | T], Target, Start, Path, Acc) ->
    case H > Target of
        true -> Acc;
        false ->
            NewAcc = case Start =/= 0 andalso H =:= lists:nth(Start, [H | T]) of
                true -> Acc;
                false -> dfs(T, Target - H, Start + 1, [H | Path], Acc)
            end,
            dfs(T, Target, Start + 1, Path, NewAcc)
    end.