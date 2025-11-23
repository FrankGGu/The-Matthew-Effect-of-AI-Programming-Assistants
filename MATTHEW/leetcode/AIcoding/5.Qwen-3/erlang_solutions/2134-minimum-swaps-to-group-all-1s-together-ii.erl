-module(minimum_swaps_to_group_all_1s_together_ii).
-export([minSwaps/1]).

minSwaps(A) ->
    N = length(A),
    TotalOnes = lists:foldl(fun(1, Acc) -> Acc + 1; (_, Acc) -> Acc end, 0, A),
    if
        TotalOnes == 0 -> 0;
        true ->
            WindowSize = TotalOnes,
            CurrentOnes = lists:foldl(fun(X, Acc) -> Acc + X end, 0, lists:sublist(A, WindowSize)),
            MaxOnes = max_ones_in_window(A, N, WindowSize, CurrentOnes, CurrentOnes),
            N - MaxOnes
    end.

max_ones_in_window(_, _, _, _, Max) -> Max;
max_ones_in_window(A, N, WindowSize, CurrentOnes, Max) ->
    if
        WindowSize >= N -> Max;
        true ->
            NextIndex = WindowSize + 1,
            NewCurrentOnes = CurrentOnes - lists:nth(NextIndex - 1, A) + lists:nth(NextIndex, A),
            NewMax = max(Max, NewCurrentOnes),
            max_ones_in_window(A, N, WindowSize, NewCurrentOnes, NewMax)
    end.