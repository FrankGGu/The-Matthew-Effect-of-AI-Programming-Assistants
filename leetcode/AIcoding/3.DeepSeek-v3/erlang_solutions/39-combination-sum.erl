-spec combination_sum(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum(Candidates, Target) ->
    lists:sort(helper(lists:sort(Candidates), Target, 0, [], [])).

helper(_, 0, _, Current, Acc) ->
    [Current | Acc];
helper([], _, _, _, Acc) ->
    Acc;
helper([H | T] = Candidates, Target, Sum, Current, Acc) when Sum + H > Target ->
    helper(T, Target, Sum, Current, Acc);
helper([H | T] = Candidates, Target, Sum, Current, Acc) ->
    Acc1 = helper(Candidates, Target, Sum + H, [H | Current], Acc),
    helper(T, Target, Sum, Current, Acc1).