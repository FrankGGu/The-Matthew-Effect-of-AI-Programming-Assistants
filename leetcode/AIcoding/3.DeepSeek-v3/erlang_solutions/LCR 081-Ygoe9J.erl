-spec combination_sum(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum(Candidates, Target) ->
    lists:sort(helper(Candidates, Target, 0, [], [])).

helper(_, 0, _, Current, Acc) ->
    [Current | Acc];
helper([], _, _, _, Acc) ->
    Acc;
helper([H | T], Target, Index, Current, Acc) ->
    if
        H > Target ->
            helper(T, Target, Index, Current, Acc);
        true ->
            NewCurrent = [H | Current],
            NewAcc = helper([H | T], Target - H, Index, NewCurrent, Acc),
            helper(T, Target, Index + 1, Current, NewAcc)
    end.