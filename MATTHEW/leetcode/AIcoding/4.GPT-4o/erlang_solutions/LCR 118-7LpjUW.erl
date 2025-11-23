-module(solution).
-export([find_redundant_directed_connection/1]).

find_redundant_directed_connection(Edges) ->
    find_redundant_directed_connection(Edges, [], 0).

find_redundant_directed_connection([], Visited, _) ->
    {0, 0};
find_redundant_directed_connection([{A, B} | Rest], Visited, 1) ->
    case dfs(B, A, Visited, [A | Rest]) of
        true -> {A, B};
        false -> find_redundant_directed_connection(Rest, [A | Visited], 1)
    end;
find_redundant_directed_connection([{A, B} | Rest], Visited, 0) ->
    case dfs(B, A, Visited, []) of
        true -> find_redundant_directed_connection(Rest, [A | Visited], 1);
        false ->
            case find_redundant_directed_connection(Rest, [A | Visited], 0) of
                {0, 0} -> {A, B};
                Result -> Result
            end
    end.

dfs(Node, Parent, Visited, Edges) ->
    case lists:member(Node, Visited) of
        true -> true;
        false ->
            NewVisited = [Node | Visited],
            lists:any(fun({X, Y}) -> (X =:= Node orelse Y =:= Node) andalso (Y =/= Parent) end, Edges) orelse
            lists:any(fun({X, Y}) -> dfs(Y, Node, NewVisited, Edges) end, Edges)
    end.