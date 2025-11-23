-module(reorder_data_in_log_files).
-export([reorder/1]).

reorder(Logs) ->
    {Logs, []} = lists:foldl(fun log_sort/2, {[], []}, Logs),
    lists:usort(Logs).

log_sort(Log, {LogList, NumList}) ->
    case is_digit(Log) of
        true ->
            {LogList, [Log | NumList]};
        false ->
            {lists:insert(1, Log, LogList), NumList}
    end.

is_digit([]) ->
    false;
is_digit([C | _]) ->
    lists:member(C, "0123456789").

sort_logs([], Acc) ->
    Acc;
sort_logs([Log | Rest], Acc) ->
    sort_logs(Rest, [Log | Acc]).

sort_logs(Logs) ->
    sort_logs(Logs, []).

compare(A, B) ->
    AStr = string:split(A, " ", 2),
    BStr = string:split(B, " ", 2),
    ARest = lists:nth(2, AStr),
    BRest = lists:nth(2, BStr),
    if
        ARest < BRest -> -1;
        ARest > BRest -> 1;
        true -> 0
    end.