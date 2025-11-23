-module(solution).
-export([good_indices/2]).

good_indices(Nums, K) ->
    N = length(Nums),
    if
        N < 2 * K + 1 -> [];
        true ->
            LeftCount = calculate_left_count(Nums),
            RightCount = calculate_right_count(Nums),
            find_good_indices(K, N, LeftCount, RightCount)
    end.

calculate_left_count(Nums) ->
    [H|_] = Nums,
    lists:reverse(calculate_left_count_recursive(tl(Nums), H, 1, [1])).

calculate_left_count_recursive([], _, _, Acc) -> Acc;
calculate_left_count_recursive([H|T], Prev, CurrentLength, Acc) ->
    if
        H =< Prev ->
            NewLength = CurrentLength + 1,
            calculate_left_count_recursive(T, H, NewLength, [NewLength|Acc]);
        true ->
            calculate_left_count_recursive(T, H, 1, [1|Acc])
    end.

calculate_right_count(Nums) ->
    N = length(Nums),
    if N == 0 -> [];
       true ->
            LastVal = lists:nth(N, Nums),
            {RightCountsReversed, _} = lists:map_foldr(
                fun(CurrentVal, {NextCount, NextVal}) ->
                    CurrentCount = if
                                       CurrentVal =< NextVal -> NextCount + 1;
                                       true -> 1
                                   end,
                    {CurrentCount, {CurrentCount, CurrentVal}}
                end,
                {1, LastVal},
                lists:droplast(Nums)
            ),
            RightCountsReversed ++ [1]
    end.

find_good_indices(K, N, LeftCount, RightCount) ->
    ZippedCounts = lists:zip(LeftCount, RightCount),
    StartIndex = K + 1,
    Length = N - 2 * K,

    SubZippedCounts = lists:sublist(ZippedCounts, StartIndex, Length),

    lists:reverse(
        lists:foldl(
            fun({LC_Val, RC_Val}, {CurrentIndex, Acc}) ->
                if
                    LC_Val >= K + 1 andalso RC_Val >= K + 1 ->
                        {CurrentIndex + 1, [CurrentIndex|Acc]};
                    true ->
                        {CurrentIndex + 1, Acc}
                end
            end,
            {K, []},
            SubZippedCounts
        )
    ).