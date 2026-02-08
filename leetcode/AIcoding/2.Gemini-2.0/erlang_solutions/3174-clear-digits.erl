-module(clear_digits).
-export([solve/1]).

solve(S) ->
  solve(S, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H|T], Acc) ->
  case Acc of
    [] ->
      solve(T, [H]);
    [A|Rest] ->
      if
        H > A ->
          solve(T, Rest ++ [H]);
        true ->
          solve(T, [A|Acc])
      end
  end.