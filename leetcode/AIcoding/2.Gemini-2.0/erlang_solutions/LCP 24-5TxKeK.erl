-module(solution).
-export([number_game/1]).

number_game(N) ->
  helper(lists:seq(1, N)).

helper([X]) ->
  X;
helper(List) ->
  NewList = lists:nthtail(1, List),
  helper(lists:sort(fun(A, B) -> A < B end, NewList)).