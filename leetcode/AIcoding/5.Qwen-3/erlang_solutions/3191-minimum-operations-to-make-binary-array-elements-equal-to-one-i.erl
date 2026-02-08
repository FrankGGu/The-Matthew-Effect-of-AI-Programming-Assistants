-module(min_operations).
-export([minOperations/1]).

minOperations(B) ->
    minOperations(B, 0, 0).

minOperations([], _, _) ->
    0;
minOperations([H | T], flip, count) when H == flip ->
    minOperations(T, flip, count);
minOperations([H | T], flip, count) ->
    minOperations(T, 1 - flip, count + 1).