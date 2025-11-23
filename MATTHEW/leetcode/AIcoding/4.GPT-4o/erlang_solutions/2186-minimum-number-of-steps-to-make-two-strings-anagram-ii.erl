-module(solution).
-export([min_steps/2]).

min_steps(S1, S2) ->
    Counts1 = count_chars(S1, dict:new()),
    Counts2 = count_chars(S2, dict:new()),
    dict:fold(fun(Key, Val1, Acc) ->
        Val2 = dict:find(Key, Counts2, 0),
        Acc + max(0, Val1 - Val2) + max(0, Val2 - Val1)
    end, 0, Counts1).

count_chars([], Counts) -> Counts;
count_chars([H | T], Counts) ->
    NewCounts = dict:store(H, dict:find(H, Counts, 0) + 1, Counts),
    count_chars(T, NewCounts).