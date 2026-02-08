-spec combination_sum3(K :: integer(), N :: integer()) -> [[integer()]].
combination_sum3(K, N) ->
    combination_sum3(K, N, 1, []).

combination_sum3(0, 0, _, Acc) -> [lists:reverse(Acc)];
combination_sum3(K, N, Start, Acc) when K > 0, N > 0 ->
    lists:flatten(
        lists:map(
            fun(X) -> 
                combination_sum3(K - 1, N - X, X + 1, [X | Acc])
            end,
            lists:seq(Start, 9)
        )
    );
combination_sum3(_, _, _, _) -> [].
