-module(solution).
-export([number_of_distinct_averages/1]).

number_of_distinct_averages(Numbers) ->
    Sorted = lists:sort(Numbers),
    Set = sets:new(),
    do_count(Sorted, Set).

do_count([], Set) ->
    sets:size(Set);
do_count([H | T], Set) ->
    [Last | _] = lists:reverse(T),
    Avg = (H + Last) / 2,
    NewSet = sets:add_element(Avg, Set),
    do_count(lists:tl(T), NewSet).