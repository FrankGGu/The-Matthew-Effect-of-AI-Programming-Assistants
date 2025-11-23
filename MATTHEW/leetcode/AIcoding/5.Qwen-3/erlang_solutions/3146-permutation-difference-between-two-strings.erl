-module(permutation_difference).
-export([difference/2]).

difference(A, B) ->
    lists:sum([abs(Index - lists:pos(Char, B)) || {Index, Char} <- lists:zip(lists:seq(0, length(A)-1), A)]).

lists:pos(Char, List) ->
    lists:pos(Char, List).