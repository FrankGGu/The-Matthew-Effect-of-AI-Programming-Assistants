-spec minimum_sum(N :: integer(), K :: integer()) -> integer().
minimum_sum(N, K) ->
    Sum = lists:sum(lists:seq(1, N)),
    case N >= K of
        true ->
            Sum + max(0, N - K + 1);
        false ->
            Sum
    end.