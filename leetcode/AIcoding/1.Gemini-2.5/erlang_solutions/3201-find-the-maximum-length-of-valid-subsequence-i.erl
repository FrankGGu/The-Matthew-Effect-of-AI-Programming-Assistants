-module(solution).
-export([max_length_valid_subsequence/2]).

max_length_valid_subsequence(Nums, K) ->
    N = length(Nums),
    case N of
        0 -> 0;
        _ ->
            NumsArray = array:from_list(Nums),
            InitialDPArray = array:new([{size, N}, {fixed, true}, {default, 1}]),
            {FinalDPArray, _Idx} = lists:foldl(
                fun(CurrentNum, {AccDPArray, CurrentIdx}) ->
                    MaxLenForCurrentNum = calculate_dp_val_array(CurrentNum, K, CurrentIdx, AccDPArray, NumsArray),
                    NewAccDPArray = array:set(CurrentIdx, MaxLenForCurrentNum, AccDPArray),
                    {NewAccDPArray, CurrentIdx + 1}
                end,
                {InitialDPArray, 0},
                Nums
            ),
            find_max_in_array(FinalDPArray, N)
    end.

calculate_dp_val_array(CurrentNum, K, CurrentIdx, AccDPArray, NumsArray) ->
    MaxLen = 1,
    calculate_dp_val_array_loop(CurrentNum, K, CurrentIdx, AccDPArray, NumsArray, 0, MaxLen).

calculate_dp_val_array_loop(CurrentNum, K, CurrentIdx, AccDPArray, NumsArray, J, MaxLen) when J < CurrentIdx ->
    PrevNum = array:get(J, NumsArray),
    PrevDP = array:get(J, AccDPArray),
    Diff = abs(CurrentNum - PrevNum),
    NewMaxLen = if
        Diff =< K -> max(MaxLen, PrevDP + 1);
        true -> MaxLen
    end,
    calculate_dp_val_array_loop(CurrentNum, K, CurrentIdx, AccDPArray, NumsArray, J + 1, NewMaxLen);
calculate_dp_val_array_loop(_CurrentNum, _K, _CurrentIdx, _AccDPArray, _NumsArray, _J, MaxLen) ->
    MaxLen.

find_max_in_array(Array, N) ->
    find_max_in_array(Array, 0, N, 0).

find_max_in_array(Array, I, N, CurrentMax) when I < N ->
    Val = array:get(I, Array),
    find_max_in_array(Array, I + 1, N, max(CurrentMax, Val));
find_max_in_array(_Array, _I, _N, CurrentMax) ->
    CurrentMax.