-module(maximum_gap).
-export([maximum_gap/1]).

maximum_gap([]) -> 0;
maximum_gap([_]) -> 0;
maximum_gap(List) ->
    Sorted = lists:sort(List),
    max_gap(Sorted, 0).

max_gap([_], Acc) -> Acc;
max_gap([H | [T | _] = Rest], Acc) ->
    Gap = T - H,
    max_gap(Rest, max(Gap, Acc)).