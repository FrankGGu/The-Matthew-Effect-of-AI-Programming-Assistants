-module(solution).
-export([minimumDifference/1]).

minimumDifference(Nums) ->
    N = length(Nums) div 3,
    {Left, Right} = lists:split(2 * N, Nums),
    LeftSorted = lists:sort(Left),
    RightSorted = lists:sort(fun(A, B) -> A >= B end, Right),

    LeftMinHeap = build_min_heap(LeftSorted),
    RightMaxHeap = build_max_heap(RightSorted),

    LeftSums = calculate_left_sums(LeftMinHeap, N),
    RightSums = calculate_right_sums(RightMaxHeap, N),

    lists:min([LeftSum - RightSum || {LeftSum, RightSum} <- lists:zip(LeftSums, RightSums)]).

build_min_heap(List) ->
    gb_sets:from_list(List).

build_max_heap(List) ->
    gb_sets:from_list(List, fun(A, B) -> A >= B end).

calculate_left_sums(Heap, N) ->
    {Sums, _} = lists:foldl(fun(_, {Acc, H}) ->
        {Min, NewHeap} = gb_sets:take_smallest(H),
        {[Min | Acc], NewHeap}
    end, {[], Heap}, lists:seq(1, N)),
    lists:reverse([lists:sum(Sums) | calculate_left_sums_rest(gb_sets:to_list(Heap), Sums, N)]).

calculate_left_sums_rest([], _, _) -> [];
calculate_left_sums_rest([H | T], Sums, N) ->
    NewSums = [H | lists:sublist(Sums, N - 1)],
    [lists:sum(NewSums) | calculate_left_sums_rest(T, NewSums, N)].

calculate_right_sums(Heap, N) ->
    {Sums, _} = lists:foldl(fun(_, {Acc, H}) ->
        {Max, NewHeap} = gb_sets:take_largest(H),
        {[Max | Acc], NewHeap}
    end, {[], Heap}, lists:seq(1, N)),
    lists:reverse([lists:sum(Sums) | calculate_right_sums_rest(gb_sets:to_list(Heap), Sums, N)]).

calculate_right_sums_rest([], _, _) -> [];
calculate_right_sums_rest([H | T], Sums, N) ->
    NewSums = [H | lists:sublist(Sums, N - 1)],
    [lists:sum(NewSums) | calculate_right_sums_rest(T, NewSums, N)].