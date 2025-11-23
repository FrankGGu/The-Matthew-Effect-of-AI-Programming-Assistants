-module(wildcard_matching).
-export([is_match/2]).

is_match(S, P) ->
  is_match(S, 0, P, 0).

is_match(S, Si, P, Pi) ->
  case {Si >= length(S), Pi >= length(P)} of
    {true, true} -> true;
    {true, false} ->
      case string:slice(P, Pi, length(P)) of
        "**" -> true;
        _ ->
          case lists:all(fun(C) -> C == $* end, string:to_list(string:slice(P, Pi, length(P)))) of
            true -> true;
            false -> false
          end
      end;
    {false, true} -> false;
    {false, false} ->
      case string:at(P, Pi) of
        $. ->
          is_match(S, Si + 1, P, Pi + 1);
        $? ->
          is_match(S, Si + 1, P, Pi + 1);
        $* ->
          is_match(S, Si, P, Pi + 1) orelse is_match(S, Si + 1, P, Pi);
        C ->
          case string:at(S, Si) of
            C -> is_match(S, Si + 1, P, Pi + 1);
            _ -> false
          end
      end
  end.