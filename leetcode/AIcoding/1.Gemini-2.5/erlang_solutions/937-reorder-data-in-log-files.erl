-module(solution).
-export([reorder_log_files/1]).

reorder_log_files(Logs) ->
    {LetterLogs, DigitLogs} = lists:partition(fun is_letter_log/1, Logs),
    SortedLetterLogs = lists:sort(fun compare_letter_logs/2, LetterLogs),
    SortedLetterLogs ++ DigitLogs.

is_letter_log(Log) ->
    [_Identifier | ContentWords] = string:tokens(Log, " "),
    FirstContentChar = hd(hd(ContentWords)),
    not erlang:is_digit(FirstContentChar).

compare_letter_logs(LogA, LogB) ->
    [IdA | ContentWordsA] = string:tokens(LogA, " "),
    [IdB | ContentWordsB] = string:tokens(LogB, " "),

    ContentA = string:join(ContentWordsA, " "),
    ContentB = string:join(ContentWordsB, " "),

    case ContentA of
        ContentB ->
            IdA < IdB; % If content is the same, compare by identifier
        _ ->
            ContentA < ContentB % Otherwise, compare by content
    end.