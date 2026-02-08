-module(largest_positive_integer).
-export([find_max_k/1]).

find_max_k(Nums) ->
    Set = sets:from_list(Nums),
    MaxK = lists:max([N || N <- Nums, sets:is_element(-N, Set), N > 0]),
    case lists:member(MaxK, Nums) of
        true -> MaxK;
        false -> -1
    end.