-module(lights3).
-export([solve/1]).

solve(A) ->
  solve(A, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H|T], Acc) ->
  solve(T, [process_node(H)|Acc]).

process_node([Id, Parent, Color]) ->
  {Id, Parent, Color}.