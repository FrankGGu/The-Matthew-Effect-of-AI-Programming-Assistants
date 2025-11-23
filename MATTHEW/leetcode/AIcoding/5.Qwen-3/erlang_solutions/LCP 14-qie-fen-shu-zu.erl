-module(solution).
-export([split_array/1]).

split_array(Nums) ->
    Total = lists:sum(Nums),
    Half = Total div 2,
    split_array(Nums, 0, Half, 0).

split_array([], _, _, Acc) ->
    Acc;
split_array([H | T], Sum, Target, Acc) ->
    NewSum = Sum + H,
    if
        NewSum == Target ->
            Acc + 1;
        NewSum < Target ->
            split_array(T, NewSum, Target, Acc + 1);
        true ->
            split_array(T, NewSum, Target, Acc)
    end.