-spec range_sum(Nums :: [integer()], N :: integer(), Left :: integer(), Right :: integer()) -> integer().
range_sum(Nums, N, Left, Right) ->
    SubSums = get_sub_sums(Nums, N),
    Sorted = lists:sort(SubSums),
    Sum = lists:sum(lists:sublist(Sorted, Left, Right - Left + 1)),
    Sum.

get_sub_sums(Nums, N) ->
    get_sub_sums(Nums, N, 0, []).

get_sub_sums([], _, _, Acc) ->
    lists:reverse(Acc);
get_sub_sums([H | T], N, Start, Acc) ->
    NewAcc = lists:foldl(
        fun(I, A) ->
            SubSum = lists:sum(lists:sublist(Nums, Start + 1, I - Start)),
            [SubSum | A]
        end,
        Acc,
        lists:seq(Start + 1, N)
    ),
    get_sub_sums(T, N, Start + 1, NewAcc).