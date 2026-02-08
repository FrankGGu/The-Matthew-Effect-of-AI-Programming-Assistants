-module(minimum_cost_to_convert_string_i).
-export([minimum_cost/3]).

minimum_cost(Source, Target, ChangeCosts) ->
    Len = length(Source),
    N = length(ChangeCosts),
    Adj = create_adj(ChangeCosts, N),
    Distances = floyd_warshall(Adj, N),

    minimum_cost_helper(Source, Target, Distances, Len).

minimum_cost_helper([], [], _, _) ->
    0;
minimum_cost_helper([S | RestS], [T | RestT], Distances, Len) ->
    SInt = char_to_int(S),
    TInt = char_to_int(T),

    case SInt =:= TInt of
        true ->
            minimum_cost_helper(RestS, RestT, Distances, Len);
        false ->
            Distances[SInt + 1][TInt + 1] + minimum_cost_helper(RestS, RestT, Distances, Len)
    end.

create_adj(ChangeCosts, N) ->
    create_adj_helper(ChangeCosts, N, array:new([0,N,N], {default, 1000000000})).

create_adj_helper([], N, Acc) ->
    Fill = lists:seq(1,N),
    Diagonal = lists:zip(Fill,Fill),
    Folded = lists:foldl(fun({I,J}, Accu) -> array:set(I, array:set(J, Accu, 0)), Accu end, Acc, Diagonal),
    Folded;
create_adj_helper([{S,T,C}|Rest], N, Acc) ->
    SInt = char_to_int(S),
    TInt = char_to_int(T),
    Acc2 = array:set(SInt+1, array:set(TInt+1, Acc, C), Acc),
    create_adj_helper(Rest, N, Acc2).

floyd_warshall(Adj, N) ->
    Adj2 = lists:map(fun(I) -> array:get(I,Adj) end, lists:seq(1,N)),
    floyd_warshall_helper(Adj2,N).

floyd_warshall_helper(Adj, N) ->
    for(K, 1, N, 1,
        for(I, 1, N, 1,
            for(J, 1, N, 1,
                Adj[I,J] := min(Adj[I,J], Adj[I,K] + Adj[K,J])
            )
        )
    ),
    Adj.

char_to_int(Char) ->
    Char - $a.