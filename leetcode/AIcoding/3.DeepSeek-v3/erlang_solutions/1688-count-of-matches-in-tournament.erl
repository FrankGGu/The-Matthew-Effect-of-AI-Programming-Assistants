-spec count_matches(N :: integer()) -> integer().
count_matches(N) ->
    count_matches(N, 0).

count_matches(1, Acc) ->
    Acc;
count_matches(N, Acc) when N rem 2 == 0 ->
    count_matches(N div 2, Acc + N div 2);
count_matches(N, Acc) ->
    count_matches((N - 1) div 2 + 1, Acc + (N - 1) div 2).