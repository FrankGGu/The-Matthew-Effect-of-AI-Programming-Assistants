-module(solution).
-export([maxSubArray/1]).

maxSubArray(Nums) ->
    max_sub_array(Nums, hd(Nums), hd(Nums)).

max_sub_array([], Max, _),
    -> Max;
max_sub_array([H|T], Max, Current),
    -> NewCurrent = max(H, Current + H),
       NewMax = max(Max, NewCurrent),
       max_sub_array(T, NewMax, NewCurrent).