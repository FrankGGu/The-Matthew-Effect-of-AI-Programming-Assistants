-module(solution).
-export([solution/1]).

solution(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    HalfLen = Len div 2,
    FirstHalf = lists:sublist(SortedNums, 1, HalfLen),
    SecondHalfReversed = lists:reverse(lists:sublist(SortedNums, HalfLen + 1, HalfLen)),
    Pairs = lists:zip(FirstHalf, SecondHalfReversed),
    lists:foldl(fun({A, B}, Max) -> max(Max, A + B) end, 0, Pairs).