-module(solution).
-export([new/1, reset/1, shuffle/1]).

new(Nums) ->
    random:seed(erlang:now()),
    array:from_list(Nums).

reset(OriginalArray) ->
    array:to_list(OriginalArray).

shuffle(OriginalArray) ->
    Size = array:size(OriginalArray),
    ShuffledArray = shuffle_array(OriginalArray, Size - 1),
    array:to_list(ShuffledArray).

shuffle_array(Arr, I) when I >= 1 ->
    J = random:uniform(I + 1) - 1,
    ValI = array:get(I, Arr),
    ValJ = array:get(J, Arr),
    Arr1 = array:set(I, ValJ, Arr),
    Arr2 = array:set(J, ValI, Arr1),
    shuffle_array(Arr2, I - 1);
shuffle_array(Arr, _I) ->
    Arr.