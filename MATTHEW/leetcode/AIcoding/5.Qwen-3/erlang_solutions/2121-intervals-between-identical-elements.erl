-module(intervals_between_identical_elements).
-export([sum_distances/1]).

sum_distances(Numbers) ->
    Map = maps:from_list([{N, [I || {I, N} <- lists:enumerate(Numbers)]} || N <- lists:usort(Numbers)]),
    lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Total) -> 
            Total + abs(I - J)
        end, 0, maps:get(Numbers, I, [])) 
    end, 0, lists:seq(1, length(Numbers))).

get_indices(Number, Numbers) ->
    [I || {I, N} <- lists:enumerate(Numbers), N == Number].