-module(maximum_possible_number).
-export([maximum_possible_number/1]).

maximum_possible_number(Numbers) ->
    Sorted = lists:sort(fun(X, Y) -> 
        (list_to_binary([X]) ++ list_to_binary([Y])) > (list_to_binary([Y]) ++ list_to_binary([X]))
    end, Numbers),
    lists:foldl(fun(X, Acc) -> Acc ++ [X] end, [], Sorted).