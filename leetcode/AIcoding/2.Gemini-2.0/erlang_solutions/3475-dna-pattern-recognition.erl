-module(dna_pattern_recognition).
-export([solve/1]).

solve(DNA) ->
  solve(DNA, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H1, H2, H3, H4 | T], Acc) ->
  Pattern = [H1, H2, H3, H4],
  case is_valid_pattern(Pattern) of
    true ->
      solve(T, [Pattern | Acc]);
    false ->
      solve(T, Acc)
  end;
solve(_, Acc) ->
  lists:reverse(Acc).

is_valid_pattern([A, B, C, D]) ->
  lists:all(fun(X) -> X == 'A' orelse X == 'T' orelse X == 'C' orelse X == 'G' end, [A, B, C, D]).