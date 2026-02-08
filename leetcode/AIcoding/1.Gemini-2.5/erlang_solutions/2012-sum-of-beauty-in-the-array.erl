-module(solution).
-export([sumOfBeauty/1]).

sumOfBeauty(Nums) ->
    N = length(Nums),
    if N < 3 -> 0;
       true ->
            NumsArray = array:from_list(Nums),
            PrefixMax = calculate_prefix_max(NumsArray, N),
            SuffixMin = calculate_suffix_min(NumsArray, N),

            calculate_total_beauty(NumsArray, PrefixMax, SuffixMin, N)
    end.

calculate_prefix_max(NumsArray, N) ->
    PrefixMax = array:new([{size, N}]),
    PrefixMax1 = array:set(0, array:get(0, NumsArray), PrefixMax),
    calculate_prefix_max_loop(1, N, NumsArray, PrefixMax1).

calculate_prefix_max_loop(I, N, NumsArray, PrefixMax) when I < N ->
    Val = array:get(I, NumsArray),
    PrevMax = array:get(I-1, PrefixMax),
    NewPrefixMax = array:set(I, max(Val, PrevMax), PrefixMax),
    calculate_prefix_max_loop(I+1, N, NumsArray, NewPrefixMax);
calculate_prefix_max_loop(_I, _N, _NumsArray, PrefixMax) ->
    PrefixMax.

calculate_suffix_min(NumsArray, N) ->
    SuffixMin = array:new([{size, N}]),
    SuffixMin1 = array:set(N-1, array:get(N-1, NumsArray), SuffixMin),
    calculate_suffix_min_loop(N-2, N, NumsArray, SuffixMin1).

calculate_suffix_min_loop(I, N, NumsArray, SuffixMin) when I >= 0 ->
    Val = array:get(I, NumsArray),
    NextMin = array:get(I+1, SuffixMin),
    NewSuffixMin = array:set(I, min(Val, NextMin), SuffixMin),
    calculate_suffix_min_loop(I-1, N, NumsArray, NewSuffixMin);
calculate_suffix_min_loop(_I, _N, _NumsArray, SuffixMin) ->
    SuffixMin.

calculate_total_beauty(NumsArray, PrefixMax, SuffixMin, N) ->
    calculate_total_beauty_loop(1, N-2, NumsArray, PrefixMax, SuffixMin, 0).

calculate_total_beauty_loop(I, MaxI, NumsArray, PrefixMax, SuffixMin, CurrentTotalBeauty) when I <= MaxI ->
    CurrentNum = array:get(I, NumsArray),
    LeftMax = array:get(I-1, PrefixMax),
    RightMin = array:get(I+1, SuffixMin),

    BeautyI = 
        if LeftMax < CurrentNum andalso CurrentNum < RightMin -> 2;
           array:get(I-1, NumsArray) < CurrentNum andalso CurrentNum < array:get(I+1, NumsArray) -> 1;
           true -> 0
        end,

    calculate_total_beauty_loop(I+1, MaxI, NumsArray, PrefixMax, SuffixMin, CurrentTotalBeauty + BeautyI);
calculate_total_beauty_loop(_I, _MaxI, _NumsArray, _PrefixMax, _SuffixMin, CurrentTotalBeauty) ->
    CurrentTotalBeauty.