-module(solution).
-export([minimum_average/1]).

minimum_average(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    HalfLen = Len div 2,
    {FrontHalf, BackHalf} = lists:split(HalfLen, SortedNums),
    ReversedBackHalf = lists:reverse(BackHalf),
    Averages = lists:zipwith(fun(A, B) -> (A + B) / 2.0 end, FrontHalf, ReversedBackHalf),
    lists:min(Averages).