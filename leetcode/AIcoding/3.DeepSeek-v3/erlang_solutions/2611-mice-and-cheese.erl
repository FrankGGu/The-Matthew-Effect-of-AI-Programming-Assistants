-spec mice_and_cheese(Reward1 :: [integer()], Reward2 :: [integer()], K :: integer()) -> integer().
mice_and_cheese(Reward1, Reward2, K) ->
    Diffs = lists:zipwith(fun(A, B) -> {A - B, A, B} end, Reward1, Reward2),
    Sorted = lists:sort(fun({Diff1, _, _}, {Diff2, _, _}) -> Diff1 >= Diff2 end, Diffs),
    {Sum, _} = lists:foldl(fun({_, A, B}, {Acc, Count}) when Count < K -> {Acc + A, Count + 1};
                              ({_, _, B}, {Acc, Count}) -> {Acc + B, Count} end, {0, 0}, Sorted),
    Sum.