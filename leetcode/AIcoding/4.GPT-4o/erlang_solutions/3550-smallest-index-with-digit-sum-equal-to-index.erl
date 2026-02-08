-module(solution).
-export([smallestEqual/1]).

smallestEqual(List) ->
    smallestEqual(List, 0).

smallestEqual([], _) -> -1;
smallestEqual([H|T], Index) ->
    Sum = H + Index,
    if
        Sum rem 10 =:= Index -> Index;
        true -> smallestEqual(T, Index + 1)
    end.