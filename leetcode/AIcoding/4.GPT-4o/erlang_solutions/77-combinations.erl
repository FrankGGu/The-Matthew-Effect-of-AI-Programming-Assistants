-spec combine(N :: integer(), K :: integer()) -> [[integer()]].
combine(N, K) ->
    combine(1, N, K, []).

combine(_, 0, _, Acc) -> [lists:reverse(Acc)];
combine(I, N, K, Acc) when I =< N ->
    combine(I + 1, N, K - 1, [I | Acc]) ++ combine(I + 1, N, K, Acc);
combine(_, _, _, _) -> [].
