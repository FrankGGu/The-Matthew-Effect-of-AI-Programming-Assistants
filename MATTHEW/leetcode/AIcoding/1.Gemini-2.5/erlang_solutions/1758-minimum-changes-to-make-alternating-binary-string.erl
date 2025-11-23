-module(solution).
-export([min_changes/1]).

min_changes(S) ->
    Changes0 = count_changes(S, $0),
    Changes1 = count_changes(S, $1),
    min(Changes0, Changes1).

count_changes(S, StartChar) ->
    count_changes_recursive(S, StartChar, 0).

count_changes_recursive([], _ExpectedChar, Acc) ->
    Acc;
count_changes_recursive([H|T], ExpectedChar, Acc) ->
    NewAcc = if H =:= ExpectedChar -> Acc;
               true -> Acc + 1
             end,
    NextExpectedChar = toggle_char(ExpectedChar),
    count_changes_recursive(T, NextExpectedChar, NewAcc).

toggle_char($0) -> $1;
toggle_char($1) -> $0.