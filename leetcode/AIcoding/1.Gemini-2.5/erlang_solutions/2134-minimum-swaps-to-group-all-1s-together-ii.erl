-module(solution).
-export([min_swaps/1]).

min_swaps(Nums) ->
    N = length(Nums),
    TotalOnes = lists:foldl(fun(X, Acc) -> Acc + X end, 0, Nums),

    if
        TotalOnes =:= 0 orelse TotalOnes =:= N ->
            0;
        true ->
            ExtendedNumsList = Nums ++ Nums,
            ExtendedNumsArray = array:from_list(ExtendedNumsList),

            InitialOnes = calculate_initial_ones(ExtendedNumsArray, TotalOnes),

            MaxOnesInWindow = slide_window(ExtendedNumsArray, N, TotalOnes, InitialOnes, InitialOnes, 0),

            TotalOnes - MaxOnesInWindow
    end.

calculate_initial_ones(Array, WindowSize) ->
    lists:foldl(fun(Index, Acc) -> Acc + array:get(Index, Array) end, 0, lists:seq(0, WindowSize - 1)).

slide_window(_Array, N, _TotalOnes, _CurrentOnes, MaxOnes, N) ->
    MaxOnes;
slide_window(Array, N, TotalOnes, CurrentOnes, MaxOnes, I) ->
    LeftElement = array:get(I, Array),
    RightElement = array:get(I + TotalOnes, Array),

    NewCurrentOnes = CurrentOnes - LeftElement + RightElement,
    NewMaxOnes = max(MaxOnes, NewCurrentOnes),

    slide_window(Array, N, TotalOnes, NewCurrentOnes, NewMaxOnes, I + 1).