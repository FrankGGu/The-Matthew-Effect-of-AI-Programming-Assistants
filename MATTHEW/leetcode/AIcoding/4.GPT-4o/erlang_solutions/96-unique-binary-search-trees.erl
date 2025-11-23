-spec num_trees(N :: integer()) -> integer().
num_trees(N) when N =< 1 -> 1;
num_trees(N) ->
    lists:sum([num_trees(I - 1) * num_trees(N - I) || I <- lists:seq(1, N)]).
