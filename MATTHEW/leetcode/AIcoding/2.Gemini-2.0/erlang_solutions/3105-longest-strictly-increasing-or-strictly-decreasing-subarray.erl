-module(longest_increasing_decreasing).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 1, 0, 0).

solve([], MaxLen, _, _) ->
  MaxLen;
solve([_], MaxLen, _, _) ->
  MaxLen;
solve([A, B | Rest], MaxLen, IncLen, DecLen) ->
  case compare(A, B) of
    '<' ->
      solve([B | Rest], max(MaxLen, IncLen + 2), IncLen + 1, 0);
    '>' ->
      solve([B | Rest], max(MaxLen, DecLen + 2), 0, DecLen + 1);
    '=' ->
      solve([B | Rest], MaxLen, 0, 0)
  end.