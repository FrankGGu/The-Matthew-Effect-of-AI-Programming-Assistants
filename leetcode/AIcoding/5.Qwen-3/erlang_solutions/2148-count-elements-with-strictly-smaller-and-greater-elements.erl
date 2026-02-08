-module(solution).
-export([count_elements/1]).

count_elements(Nums) ->
    Sorted = lists:sort(Nums),
    Min = hd(Sorted),
    Max = lists:last(Sorted),
    Count = length(Nums) - 2,
    if
        Min == Max -> 0;
        true -> Count
    end.