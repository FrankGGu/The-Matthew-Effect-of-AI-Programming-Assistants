-module(find_the_difference).
-export([find_difference/2]).

find_difference(A, B) ->
    SetA = sets:from_list(A),
    SetB = sets:from_list(B),
    DiffA = sets:subtract(SetA, SetB),
    DiffB = sets:subtract(SetB, SetA),
    lists:flatten([sets:to_list(DiffA), sets:to_list(DiffB)]).