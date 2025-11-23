-module(separate_squares_i).
-export([solve/1]).

solve(n) ->
  solve(n, 1, n div 2).

solve(N, A, B) when A > B ->
  false;
solve(N, A, B) ->
  Sum = A * A + B * B,
  case N =:= Sum of
    true ->
      true;
    false ->
      case N < Sum of
        true ->
          solve(N, A, B - 1);
        false ->
          solve(N, A + 1, B)
      end
  end.