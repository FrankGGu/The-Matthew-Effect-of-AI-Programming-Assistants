-module(solution).
-export([count_substrings/1]).

-define(MOD, 1000000007).

count_substrings(S) ->
    count_substrings_acc(S, 0, 0).

count_substrings_acc([], CurrentOnes, Total) ->
    (Total + (CurrentOnes * (CurrentOnes + 1) div 2)) rem ?MOD;
count_substrings_acc([$1 | T], CurrentOnes, Total) ->
    count_substrings_acc(T, CurrentOnes + 1, Total);
count_substrings_acc([$0 | T], CurrentOnes, Total) ->
    NewTotal = (Total + (CurrentOnes * (CurrentOnes + 1) div 2)) rem ?MOD,
    count_substrings_acc(T, 0, NewTotal).