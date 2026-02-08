-module(solution).
-export([valid_path/4]).

valid_path(N, Edges, Start, End) ->
    Adj = build_adjacency_list(N, Edges),
    Visited = array:new(N, {default, false}),
    dfs(Start, End, Adj, Visited).

build_adjacency_list(N, Edges) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
                    array:set(V, [U | array:get(V, Acc1)], Acc1)
                end, Adj, Edges).

dfs(Start, End, Adj, Visited) ->
    case Start =:= End of
        true -> true;
        false ->
            case array:get(Start, Visited) of
                true -> false;
                false ->
                    Visited1 = array:set(Start, true, Visited),
                    lists:any(fun(Neighbor) -> 
                                dfs(Neighbor, End, Adj, Visited1) 
                              end, array:get(Start, Adj))
            end
    end.