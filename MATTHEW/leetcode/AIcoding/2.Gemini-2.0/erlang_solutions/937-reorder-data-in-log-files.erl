-module(reorder_log_files).
-export([reorderLogFiles/1]).

reorderLogFiles(Logs) ->
  {LetterLogs, DigitLogs} = lists:partition(fun(Log) ->
    [H | T] = string:split(Log, " ", all),
    case string:to_integer(hd(T)) of
      {_, _} -> false;
      error -> true
    end
  end, Logs),

  SortedLetterLogs = lists:keysort(1, [
    {string:join(tl(string:split(Log, " ", all)), " "), hd(string:split(Log, " ", all))} || Log <- LetterLogs
  ]),

  ReorderedLetterLogs = [
    hd([Log || Log <- LetterLogs, hd(string:split(Log, " ", all)) == Id]) ++ " " ++ Key || {Key, Id} <- SortedLetterLogs
  ],

  ReorderedLetterLogs ++ DigitLogs.