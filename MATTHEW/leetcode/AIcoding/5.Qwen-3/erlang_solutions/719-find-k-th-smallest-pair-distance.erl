-module(solution).
-export([find_kth_smallest/2]).

find_kth_smallest(Nums, K) ->
    lists:sort(Nums),
    N = length(Nums),
    Low = 0,
    High = lists:last(Nums) - lists:first(Nums),
    find_kth_smallest(Nums, K, Low, High).

find_kth_smallest(_, _, Low, High) when Low == High ->
    Low;
find_kth_smallest(Nums, K, Low, High) ->
    Mid = (Low + High) div 2,
    Count = count_pairs(Nums, Mid),
    if
        Count >= K ->
            find_kth_smallest(Nums, K, Low, Mid);
        true ->
            find_kth_smallest(Nums, K, Mid + 1, High)
    end.

count_pairs(Nums, T) ->
    N = length(Nums),
    Count = 0,
    Left = 0,
    Right = 0,
    lists:foldl(fun(_I, Acc) -> 
                    Right = 0,
                    lists:foldl(fun(J, Acc2) ->
                                    if
                                        Nums ! J - Nums ! Left <= T ->
                                            Acc2 + 1;
                                        true ->
                                            Acc2
                                    end
                                end, Acc, lists:seq(Left+1, N-1))
                end, 0, lists:seq(0, N-1)).

-module(solution).
-export([find_kth_smallest/2]).

find_kth_smallest(Nums, K) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Low = 0,
    High = Sorted -- [hd(Sorted)] -- [last(Sorted)],
    find_kth_smallest(Sorted, K, Low, High).

find_kth_smallest(_, _, Low, High) when Low == High ->
    Low;
find_kth_smallest(Sorted, K, Low, High) ->
    Mid = (Low + High) div 2,
    Count = count_pairs(Sorted, Mid),
    if
        Count >= K ->
            find_kth_smallest(Sorted, K, Low, Mid);
        true ->
            find_kth_smallest(Sorted, K, Mid + 1, High)
    end.

count_pairs(Sorted, T) ->
    N = length(Sorted),
    Count = 0,
    Left = 0,
    Right = 0,
    lists:foldl(fun(I, Acc) ->
                    Right = I + 1,
                    while Right < N and Sorted[Right] - Sorted[I] <= T do
                        Acc + 1,
                        Right = Right + 1
                    end,
                    Acc
                end, 0, lists:seq(0, N-1)).