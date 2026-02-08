-spec count_orders(N :: integer()) -> integer().
count_orders(N) ->
    count_orders(N, 1).

count_orders(0, Acc) ->
    Acc rem 1000000007;
count_orders(N, Acc) ->
    NewAcc = (Acc * N * (2 * N - 1)) rem 1000000007,
    count_orders(N - 1, NewAcc).