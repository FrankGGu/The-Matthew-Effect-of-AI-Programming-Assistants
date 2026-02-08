-module(crawler_log_folder).
-export([min_operations/1]).

min_operations(Logs) ->
    min_operations(Logs, 0).

min_operations([], Acc) ->
    Acc;
min_operations(["../" | Rest], Acc) when Acc > 0 ->
    min_operations(Rest, Acc - 1);
min_operations(["../" | Rest], Acc) ->
    min_operations(Rest, Acc);
min_operations(["./" | Rest], Acc) ->
    min_operations(Rest, Acc);
min_operations([_ | Rest], Acc) ->
    min_operations(Rest, Acc + 1).