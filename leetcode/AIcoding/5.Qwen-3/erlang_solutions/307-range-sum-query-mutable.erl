-module(rangesumquerymutable).
-export([new/1, update/3, sum_range/3]).

new(Nums) ->
    {array, array:from_list(Nums)}.

update({array, Arr}, Index, Value) ->
    NewArr = array:set(Index, Value, Arr),
    {array, NewArr}.

sum_range({array, Arr}, Left, Right) ->
    array:foldl(fun(I, Acc) -> if I >= Left andalso I =< Right -> Acc + array:get(I, Arr); true -> Acc end end, 0, array:to_list(array:indices(Arr))).