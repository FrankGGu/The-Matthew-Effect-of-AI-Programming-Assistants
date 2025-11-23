-module(array_partition).
-export([is_possible/1]).

is_possible(Nums) ->
    Sorted = lists:sort(Nums),
    helper(Sorted, 0).

helper([], Sum) ->
    Sum;
helper([A, B | T], Sum) ->
    helper(T, Sum + A).