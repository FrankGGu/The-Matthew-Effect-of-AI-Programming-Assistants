-module(solution).
-export([attendance_record_i/1]).

attendance_record_i(S) ->
  case string:find(S, "LLL", all) == nomatch of
    true ->
      case lists:filter(fun(C) -> C == 'A' end, string:to_list(S)) of
        As when length(As) > 1 ->
          false;
        _ ->
          true
      end;
    false ->
      false
  end.