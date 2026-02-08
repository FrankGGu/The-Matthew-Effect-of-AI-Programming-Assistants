-spec recover_array(N :: integer(), Sums :: [integer()]) -> [integer()].
recover_array(N, Sums) ->
    Sorted = lists:sort(Sums),
    recover(Sorted, N, []).

recover([0], 0, Acc) ->
    lists:reverse(Acc);
recover(Sums, N, Acc) ->
    Diff = lists:nth(2, Sums) - lists:nth(1, Sums),
    {Sums1, Sums2} = split_subsets(Sums, Diff),
    recover(Sums1, N - 1, [Diff | Acc]).

split_subsets(Sums, Num) ->
    split_subsets(Sums, Num, [], []).

split_subsets([], _, Sums1, Sums2) ->
    {lists:sort(Sums1), lists:sort(Sums2)};
split_subsets([H | T], Num, Sums1, Sums2) ->
    case lists:member(H + Num, T) of
        true ->
            NewT = lists:delete(H + Num, T),
            split_subsets(NewT, Num, [H | Sums1], [H + Num | Sums2]);
        false ->
            split_subsets(T, Num, Sums1, Sums2)
    end.