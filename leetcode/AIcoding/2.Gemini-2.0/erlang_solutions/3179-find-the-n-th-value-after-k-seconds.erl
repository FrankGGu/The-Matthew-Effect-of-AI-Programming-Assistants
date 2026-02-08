-module(solution).
-export([solve/3]).

solve(N, K, A) ->
  Len = length(A),
  if Len == 0 ->
    N;
  true ->
    K rem Len
  end,
  solve_helper(N, K rem Len, A).

solve_helper(N, 0, A) ->
  N;
solve_helper(N, K, A) ->
  Head = hd(A),
  Tail = tl(A),
  solve_helper(Head, K - 1, Tail ++ [N]).