-module(solution).
-export([smallestEqual/1]).

smallestEqual(IndexList) ->
    smallestEqual(IndexList, 0).

smallestEqual([], _) -> -1;
smallestEqual([H | T], Index) ->
    if
        H rem 10 =:= Index -> Index;
        true -> smallestEqual(T, Index + 1)
    end.