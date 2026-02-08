-module(solution).
-export([solve/1]).

solve(routes) ->
  solve(routes, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H|T], Acc) ->
  solve(T, process_route(H, Acc)).

process_route([], Acc) ->
  Acc;
process_route([Node|Rest], Acc) ->
  case lists:member(Node, Acc) of
    true ->
      process_route(Rest, Acc);
    false ->
      process_route(Rest, [Node|Acc])
  end.