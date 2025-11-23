-module(solution).
-export([candy/1]).

-include_lib("stdlib/include/array.hrl").

candy(Ratings) ->
    N = length(Ratings),
    if N == 0 -> 0;
       true ->
            CandiesArray = array:new([{size, N}, {fixed, true}, {default, 1}]),
            RatingsArray = list_to_array(Ratings, N),

            CandiesArray1 = left_pass(RatingsArray, CandiesArray, N),
            CandiesArray2 = right_pass(RatingsArray, CandiesArray1, N),

            sum_array(CandiesArray2, N)
    end.

list_to_array(List, N) ->
    list_to_array_iter(List, array:new([{size, N}, {fixed, true}]), 0).

list_to_array_iter([], Arr, _Idx) -> Arr;
list_to_array_iter([H|T], Arr, Idx) ->
    list_to_array_iter(T, array:set(Idx, H, Arr), Idx + 1).

left_pass(RatingsArr, CandiesArr, N) ->
    left_pass_iter(RatingsArr, CandiesArr, 1, N).

left_pass_iter(_RatingsArr, CandiesArr, N, N) -> CandiesArr;
left_pass_iter(RatingsArr, CandiesArr, I, N) ->
    R_prev = array:get(I-1, RatingsArr),
    R_curr = array:get(I, RatingsArr),
    C_prev = array:get(I-1, CandiesArr),

    NewCandiesArr =
        if R_curr > R_prev ->
            array:set(I, C_prev + 1, CandiesArr);
        true ->
            CandiesArr
        end,
    left_pass_iter(RatingsArr, NewCandiesArr, I + 1, N).

right_pass(RatingsArr, CandiesArr, N) ->
    right_pass_iter(RatingsArr, CandiesArr, N - 2, N).

right_pass_iter(_RatingsArr, CandiesArr, -1, _N) -> CandiesArr;
right_pass_iter(RatingsArr, CandiesArr, I, N) ->
    R_curr = array:get(I, RatingsArr),
    R_next = array:get(I+1, RatingsArr),
    C_curr = array:get(I, CandiesArr),
    C_next = array:get(I+1, CandiesArr),

    NewCandiesArr =
        if R_curr > R_next ->
            array:set(I, max(C_curr, C_next + 1), CandiesArr);
        true ->
            CandiesArr
        end,
    right_pass_iter(RatingsArr, NewCandiesArr, I - 1, N).

sum_array(Arr, N) ->
    sum_array_iter(Arr, 0, N, 0).

sum_array_iter(_Arr, N, N, Acc) -> Acc;
sum_array_iter(Arr, I, N, Acc) ->
    Value = array:get(I, Arr),
    sum_array_iter(Arr, I + 1, N, Acc + Value).