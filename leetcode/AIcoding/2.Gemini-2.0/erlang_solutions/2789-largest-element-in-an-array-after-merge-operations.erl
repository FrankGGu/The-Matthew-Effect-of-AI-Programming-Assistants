-module(largest_element).
-export([largest_element/1]).

largest_element(Nums) ->
    largest_element_helper(Nums, 0).

largest_element_helper([], Acc) ->
    Acc;
largest_element_helper([H | T], Acc) ->
    case H >= Acc of
        true ->
            largest_element_helper(T, H);
        false ->
            largest_element_helper(T, Acc + H)
    end.