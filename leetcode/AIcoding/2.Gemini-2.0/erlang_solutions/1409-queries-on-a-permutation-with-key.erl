-module(permutation_with_key).
-export([process_queries/2]).

process_queries(Queries, M) ->
  process_queries(Queries, lists:seq(1, M), []).

process_queries([], _P, Acc) ->
  lists:reverse(Acc);
process_queries([Q | Rest], P, Acc) ->
  {Index, NewP} = find_and_move(Q, P),
  process_queries(Rest, NewP, [Index | Acc]).

find_and_move(Q, P) ->
  {Index, RestP} = find_index(Q, P, 0),
  {Index, [Q | RestP]}.

find_index(Q, [Q | Rest], Index) ->
  {Index, Rest};
find_index(Q, [_ | Rest], Index) ->
  find_index(Q, Rest, Index + 1).