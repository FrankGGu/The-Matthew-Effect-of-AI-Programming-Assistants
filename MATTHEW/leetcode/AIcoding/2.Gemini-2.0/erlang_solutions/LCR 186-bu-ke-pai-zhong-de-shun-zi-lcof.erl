-module(solution).
-export([solve/1]).

solve(Artifacts) ->
  case Artifacts of
    [] ->
      "Unknown";
    [H|T] ->
      case same_dynasty([H|T]) of
        true ->
          lists:nth(1, H);
        false ->
          "Mixed"
      end
  end.

same_dynasty([]) ->
  true;
same_dynasty([H|T]) ->
  case T of
    [] ->
      true;
    [Next|Rest] ->
      case lists:nth(1, H) =:= lists:nth(1, Next) of
        true ->
          same_dynasty([Next|Rest]);
        false ->
          false
      end
  end.