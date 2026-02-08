-spec make_integer_beautiful(N :: integer(), Target :: integer()) -> integer().
make_integer_beautiful(N, Target) ->
    Sum = fun(X) -> lists:sum([ C - $0 || C <- integer_to_list(X) ]) end,
    K = 0,
    loop(N, Target, Sum, K).

loop(N, Target, Sum, K) ->
    case Sum(N + K) =< Target of
        true -> K;
        false ->
            Pow = 10 - (N + K) rem 10,
            NewK = K + Pow,
            loop(N + Pow, Target, Sum, NewK)
    end.