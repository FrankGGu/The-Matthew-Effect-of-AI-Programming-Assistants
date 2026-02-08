-module(max_consecutive_ones).
-export([find_max_consecutive_ones/1]).

find_max_consecutive_ones(Nums) ->
    find_max_consecutive_ones(Nums, 0, 0).

find_max_consecutive_ones([], Current, Max) ->
    max(Current, Max);
find_max_consecutive_ones([1 | Rest], Current, Max) ->
    find_max_consecutive_ones(Rest, Current + 1, Max);
find_max_consecutive_ones([_ | Rest], Current, Max) ->
    find_max_consecutive_ones(Rest, 0, max(Current, Max)).

max(A, B) ->
    if A > B -> A;
       true -> B
    end.