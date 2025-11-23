-spec decrypt(Code :: [integer()], K :: integer()) -> [integer()].
decrypt(Code, K) ->
    N = length(Code),
    if
        K == 0 ->
            lists:duplicate(N, 0);
        K > 0 ->
            decrypt_positive(Code, K, N);
        true ->
            decrypt_negative(Code, -K, N)
    end.

decrypt_positive(Code, K, N) ->
    lists:map(fun(I) ->
        Sum = lists:sum(lists:sublist(Code, I + 1, K)),
        Sum
    end, lists:seq(0, N - 1)).

decrypt_negative(Code, K, N) ->
    lists:map(fun(I) ->
        Start = if
            I - K < 0 -> N + (I - K);
            true -> I - K
        end,
        Sum = lists:sum(lists:sublist(Code, Start + 1, K)),
        Sum
    end, lists:seq(0, N - 1)).