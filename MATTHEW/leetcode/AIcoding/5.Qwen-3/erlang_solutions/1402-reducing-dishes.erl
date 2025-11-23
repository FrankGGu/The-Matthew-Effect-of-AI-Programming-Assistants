-module(reducing_dishes).
-export([max_satisfaction/1]).

max_satisfaction(Satisfaction) ->
    Sorted = lists:sort(Satisfaction),
    max_satisfaction(Sorted, 0, 0, 0).

max_satisfaction([], _, _, Acc) ->
    Acc;
max_satisfaction([H | T], Index, Total, Acc) ->
    NewTotal = Total + H,
    NewAcc = Acc + NewTotal,
    max_satisfaction(T, Index + 1, NewTotal, NewAcc).