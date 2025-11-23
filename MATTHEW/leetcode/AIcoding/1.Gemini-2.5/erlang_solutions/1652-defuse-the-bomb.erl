-module(solution).
-export([defuse_bomb/2]).

defuse_bomb(Code, 0) ->
    lists:duplicate(length(Code), 0);
defuse_bomb(Code, K) ->
    N = length(Code),
    if N == 0 ->
        [];
    true ->
        CodeArray = array:from_list(Code),
        ResultArray = calculate_bomb_array(CodeArray, N, K),
        array:to_list(ResultArray)
    end.

calculate_bomb_array(CodeArray, N, K) when K > 0 ->
    InitialSum = sum_range_forward(CodeArray, N, 0, K),

    ResultArray = array:new([{size, N}, {fixed, true}]),
    ResultArray1 = array:set(0, InitialSum, ResultArray),

    {_FinalSum, FinalResultArray} = lists:foldl(fun(I, {CurrentSum, AccArray}) ->
        RemoveVal = array:get(I, CodeArray),
        AddVal = array:get((I + K) rem N, CodeArray),

        NewSum = CurrentSum - RemoveVal + AddVal,
        NewAccArray = array:set(I, NewSum, AccArray),
        {NewSum, NewAccArray}
    end, {InitialSum, ResultArray1}, lists:seq(1, N - 1)),
    FinalResultArray.

calculate_bomb_array(CodeArray, N, K) when K < 0 ->
    AbsK = abs(K),

    InitialSum = sum_range_backward(CodeArray, N, 0, AbsK),

    ResultArray = array:new([{size, N}, {fixed, true}]),
    ResultArray1 = array:set(0, InitialSum, ResultArray),

    {_FinalSum, FinalResultArray} = lists:foldl(fun(I, {CurrentSum, AccArray}) ->
        RemoveVal = array:get((I - AbsK - 1 + N) rem N, CodeArray),
        AddVal = array:get((I - 1 + N) rem N, CodeArray),

        NewSum = CurrentSum - RemoveVal + AddVal,
        NewAccArray = array:set(I, NewSum, AccArray),
        {NewSum, NewAccArray}
    end, {InitialSum, ResultArray1}, lists:seq(1, N - 1)),
    FinalResultArray.

sum_range_forward(CodeArray, N, StartIdx, Count) ->
    lists:sum([array:get((StartIdx + J) rem N, CodeArray) || J <- lists:seq(1, Count)]).

sum_range_backward(CodeArray, N, StartIdx, Count) ->
    lists:sum([array:get((StartIdx - J + N) rem N, CodeArray) || J <- lists:seq(1, Count)]).