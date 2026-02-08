-module(minimum_number_of_work_sessions).
-export([min_sessions/1]).

min_sessions(Tasks) ->
    min_sessions(Tasks, 0, 0, 0, 0).

min_sessions([], _, _, Min, _) ->
    Min;
min_sessions([H | T], CurrentSum, Count, Min, Total) when CurrentSum + H > Total ->
    min_sessions(T, H, 1, min(Min, Count + 1), Total);
min_sessions([H | T], CurrentSum, Count, Min, Total) ->
    min_sessions(T, CurrentSum + H, Count + 1, Min, Total).