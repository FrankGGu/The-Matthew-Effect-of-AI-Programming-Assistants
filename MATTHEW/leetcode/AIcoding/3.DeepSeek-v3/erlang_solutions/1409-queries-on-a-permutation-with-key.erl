-module(solution).
-export([process_queries/2]).

process_queries(Queries, M) ->
    P = lists:seq(1, M),
    process_queries(Queries, P, []).

process_queries([], _, Acc) ->
    lists:reverse(Acc);
process_queries([Q | Rest], P, Acc) ->
    Index = find_index(Q, P, 0),
    NewP = [lists:nth(Index + 1, P) | lists:sublist(P, Index) ++ lists:nthtail(Index + 1, P)],
    process_queries(Rest, NewP, [Index | Acc]).

find_index(Value, [Value | _], Index) ->
    Index;
find_index(Value, [_ | T], Index) ->
    find_index(Value, T, Index + 1).