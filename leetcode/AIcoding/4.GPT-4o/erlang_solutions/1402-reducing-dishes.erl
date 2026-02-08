-module(solution).
-export([maxSatisfaction/1]).

maxSatisfaction(Dishes) ->
    Sorted = lists:sort(Dishes),
    max_satisfaction(Sorted, 0, 0).

max_satisfaction([], _, Acc) -> Acc;
max_satisfaction(List, Time, Acc) ->
    NewAcc = Acc + lists:sum(List) * Time,
    NewTime = Time + 1,
    max_satisfaction(tl(List), NewTime, NewAcc).