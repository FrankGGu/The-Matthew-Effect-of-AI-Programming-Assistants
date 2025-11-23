-spec num_trees(N :: integer()) -> integer().
num_trees(N) ->
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    DP2 = array:set(1, 1, DP1),
    num_trees(2, N, DP2).

num_trees(I, N, DP) when I > N ->
    array:get(N, DP);
num_trees(I, N, DP) ->
    Sum = lists:sum([array:get(J - 1, DP) * array:get(I - J, DP) || J <- lists:seq(1, I)]),
    NewDP = array:set(I, Sum, DP),
    num_trees(I + 1, N, NewDP).