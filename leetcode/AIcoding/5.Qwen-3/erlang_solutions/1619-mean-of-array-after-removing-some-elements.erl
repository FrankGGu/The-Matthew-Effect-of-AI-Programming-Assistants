-module(median_of_array_after_removing_some_elements).
-export([mean/1]).

mean(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Remove = floor(Len / 5),
    Trimmed = lists:sublist(Sorted, Remove+1, Len - 2*Remove),
    Sum = lists:sum(Trimmed),
    Length = length(Trimmed),
    Sum / Length.