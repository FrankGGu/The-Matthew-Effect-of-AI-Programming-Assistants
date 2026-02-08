-module(solution).
-export([distinct_averages/1]).

distinct_averages(Nums) ->
    SortedNums = lists:sort(Nums),
    process_averages(SortedNums, gb_sets:new()).

process_averages(L, AccSet) when length(L) < 2 ->
    gb_sets:size(AccSet);
process_averages(L, AccSet) ->
    [H | T] = L,
    Last = lists:last(T),
    Remaining = lists:droplast(T),
    Average = (H + Last) / 2.0,
    NewAccSet = gb_sets:add(Average, AccSet),
    process_averages(Remaining, NewAccSet).