-module(matrix_rotation).
-export([solve/2]).

solve(Matrix, Target) ->
  solve_helper(Matrix, Target, 0).

solve_helper(Matrix, Target, 4) ->
  false;
solve_helper(Matrix, Target, RotationCount) ->
  if
    lists:flatten(Matrix) =:= lists:flatten(Target) ->
      true;
    true ->
      solve_helper(rotate(Matrix), Target, RotationCount + 1)
  end.

rotate(Matrix) ->
  N = length(Matrix),
  lists:map(fun(I) ->
              lists:map(fun(J) ->
                          lists:nth(I, lists:nth(N - J + 1, Matrix))
                        end, lists:seq(1, N))
            end, lists:seq(1, N)).