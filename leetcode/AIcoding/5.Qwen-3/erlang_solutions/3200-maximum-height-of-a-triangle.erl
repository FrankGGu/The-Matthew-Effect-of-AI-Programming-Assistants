-module(maximum_height_of_a_triangle).
-export([height/1]).

height(Nums) ->
    lists:sort(lists:reverse(Nums)),
    height(Nums, 0, 0).

height([], _, Acc) ->
    Acc;
height([H | T], Level, Acc) ->
    if
        H >= Level + 1 ->
            height(T, Level + 1, Acc + 1);
        true ->
            Acc
    end.