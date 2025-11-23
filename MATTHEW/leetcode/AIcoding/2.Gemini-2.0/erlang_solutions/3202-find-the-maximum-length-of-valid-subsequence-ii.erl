-module(max_valid_subsequence).
-export([solve/1]).

solve(nums) ->
  solve(nums, []).

solve([], Acc) ->
  lists:sum(Acc);
solve([H|T], Acc) ->
  case check_valid(H, Acc) of
    true ->
      solve(T, [H|Acc]);
    false ->
      Solve1 = solve(T, [H|Acc]),
      Solve2 = solve(T, Acc),
      max(Solve1, Solve2)
  end.

check_valid(Num, Acc) ->
  lists:all(fun(X) -> Num rem X /= 0 and X rem Num /= 0 end, Acc).