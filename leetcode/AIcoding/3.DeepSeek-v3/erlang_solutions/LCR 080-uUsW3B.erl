-spec combine(N :: integer(), K :: integer()) -> [[integer()]].
combine(N, K) ->
    combine(1, N, K).

combine(Start, N, K) when K =:= 0 ->
    [[]];
combine(Start, N, K) when Start > N ->
    [];
combine(Start, N, K) ->
    Without = combine(Start + 1, N, K),
    With = combine(Start + 1, N, K - 1),
    [[Start | Rest] || Rest <- With] ++ Without.