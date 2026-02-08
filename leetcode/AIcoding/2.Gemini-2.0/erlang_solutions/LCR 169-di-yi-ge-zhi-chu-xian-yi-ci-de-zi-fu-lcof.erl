-module(solution).
-export([solve/1]).

solve(S) ->
  solve_helper(S, []).

solve_helper([], Acc) ->
  [lists:reverse(Acc)];
solve_helper([H|T], Acc) ->
  case is_number(H) of
    true ->
      solve_helper(T, [H|Acc]);
    false ->
      case H of
        "+" ->
          [lists:reverse(Acc) | solve_helper(T, [])];
        "-" ->
          [lists:reverse(Acc) | solve_helper(T, [])];
        "*" ->
          [lists:reverse(Acc) | solve_helper(T, [])];
        "/" ->
          [lists:reverse(Acc) | solve_helper(T, [])];
        _ ->
          solve_helper(T, [H|Acc])
      end
  end.