-spec arrange_coins(N :: integer()) -> integer().
arrange_coins(N) ->
    arrange_coins(N, 1, 0).

arrange_coins(N, K, Steps) when N >= K ->
    arrange_coins(N - K, K + 1, Steps + 1);
arrange_coins(_, _, Steps) ->
    Steps.