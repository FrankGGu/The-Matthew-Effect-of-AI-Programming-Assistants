-module(solution).
-export([beauty_sum/1]).

beauty_sum(S) ->
    len(S, 0, 0).

len([], Acc, Sum) -> Sum + Acc;
len([H | T], Acc, Sum) ->
    NewAcc = Acc + 1,
    Counts = counts([H | T], dict:new()),
    Max = dict:fold(fun(_, V, Acc) -> max(Acc, V) end, 0, Counts),
    Min = dict:fold(fun(_, V, Acc) -> min(Acc, V) end, 1, Counts),
    Total = Max - Min,
    len(T, NewAcc + Total, Sum).

counts([], Counts) -> Counts;
counts([H | T], Counts) ->
    NewCounts = dict:update(H, fun(X) -> X + 1 end, 1, Counts),
    counts(T, NewCounts).