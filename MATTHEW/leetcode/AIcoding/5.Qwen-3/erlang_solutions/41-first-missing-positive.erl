-module(first_missing_positive).
-export([first_missing_positive/1]).

first_missing_positive([]) -> 1;
first_missing_positive(List) ->
    N = length(List),
    Arrays = lists:sublist(lists:usort(List), N),
    do_first_missing_positive(Arrays, 1).

do_first_missing_positive([], _) -> 1;
do_first_missing_positive([H | T], Expected) when H == Expected ->
    do_first_missing_positive(T, Expected + 1);
do_first_missing_positive([H | _], Expected) when H > Expected ->
    Expected;
do_first_missing_positive([_ | T], Expected) ->
    do_first_missing_positive(T, Expected).