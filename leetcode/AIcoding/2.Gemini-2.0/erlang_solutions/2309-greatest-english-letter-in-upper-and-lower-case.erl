-module(greatest_letter).
-export([greatest_letter/1]).

greatest_letter(S) ->
  Uppers = [C || C <- string:to_upper(S), string:is_upper(C)],
  Lowers = [C || C <- string:to_lower(S), string:is_lower(C)],
  Common = lists:sort([C || C <- Uppers, lists:member(string:to_lower(C), Lowers)]),
  case lists:reverse(Common) of
    [] -> "";
    [H|_] -> string:substr(H,1,1)
  end.