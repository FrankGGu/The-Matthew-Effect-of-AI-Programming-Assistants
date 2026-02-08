-module(block_placement_queries).
-export([block_placement_queries/2]).

block_placement_queries(N, Queries) ->
  block_placement_queries(N, Queries, []).

block_placement_queries(_, [], Acc) ->
  lists:reverse(Acc);
block_placement_queries(N, [Query | Rest], Acc) ->
  case can_place(N, Query) of
    true ->
      block_placement_queries(N, Rest, [true | Acc]);
    false ->
      block_placement_queries(N, Rest, [false | Acc])
  end.

can_place(N, [Start, Length]) ->
  case (Start >= 0) and (Start + Length - 1 < N) of
    true -> true;
    false -> false
  end.