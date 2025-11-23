-module(solution).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H | T], Acc) ->
  {Len, Rest} = find_len([H | T], 1),
  solve(Rest, [Len | Acc]).

find_len([_], Len) ->
  {Len, []};
find_len([A, B | T], Len) when A < B ->
  find_len([B | T], Len + 1);
find_len(L, Len) ->
  {Len, L}.