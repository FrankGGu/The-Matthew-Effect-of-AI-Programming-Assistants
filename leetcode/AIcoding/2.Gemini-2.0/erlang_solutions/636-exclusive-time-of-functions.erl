-module(exclusive_time).
-export([exclusive_time/2]).

exclusive_time(N, Logs) ->
  exclusive_time_helper(Logs, [], 0, 0, []).

exclusive_time_helper([], _, _, _, Acc) ->
  lists:reverse(Acc);
exclusive_time_helper([Log | Rest], Stack, PrevTime, TotalTime, Acc) ->
  {FuncId, Type, Time} = parse_log(Log),
  case Type of
    start ->
      case Stack of
        [] ->
          exclusive_time_helper(Rest, [{FuncId, Time}] ++ Stack, Time, TotalTime, Acc);
        [{PrevFuncId, _} | _] ->
          Diff = Time - PrevTime;
          NewAcc = lists:nth(PrevFuncId + 1, Acc) + Diff;
          NewAccList = lists:nthreplace(PrevFuncId + 1, Acc, NewAcc);
          exclusive_time_helper(Rest, [{FuncId, Time}] ++ Stack, Time, TotalTime, NewAccList)
      end;
    finish ->
      [{TopFuncId, StartTime} | T] = Stack,
      Diff = Time - StartTime + 1;
      NewAcc = lists:nth(TopFuncId + 1, Acc) + Diff;
      NewAccList = lists:nthreplace(TopFuncId + 1, Acc, NewAcc);
      exclusive_time_helper(Rest, T, Time + 1, TotalTime, NewAccList)
  end.

parse_log(Log) ->
  [FuncIdStr, TypeStr, TimeStr] = string:tokens(Log, ":"),
  FuncId = list_to_integer(FuncIdStr),
  Type = list_to_atom(TypeStr),
  Time = list_to_integer(TimeStr),
  {FuncId, Type, Time}.