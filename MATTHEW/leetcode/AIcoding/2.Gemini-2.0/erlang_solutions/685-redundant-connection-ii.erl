-module(redundant_connection_ii).
-export([find_redundant_directed_connection/1]).

find_redundant_directed_connection(Edges) ->
    N = lists:max([U || {U, V} <- Edges] ++ [V || {U, V} <- Edges]);

    in_degree(Edges, N, InDegrees),

    case [V || {V, Degree} <- InDegrees, Degree > 1] of
        [] ->
            cycle_case(Edges, N);
        [V] ->
            multiple_parent_case(Edges, V, N);
        _ ->
            [0,0]
    end.

in_degree(Edges, N, Acc) ->
    in_degree(Edges, N, [], Acc).

in_degree([], _, Acc, Acc) ->
    Acc;
in_degree([{_, V} | Rest], N, Acc, Acc0) ->
    case lists:keyfind(V, 1, Acc0) of
        false ->
            in_degree(Rest, N, [{V, 1} | Acc], Acc0);
        {V, Degree} ->
            in_degree(Rest, N, lists:keyreplace(V, 1, Acc, {V, Degree + 1}), Acc0)
    end.

multiple_parent_case(Edges, V, N) ->
    Candidates = [{U, V} || {U, V} <- Edges],

    case check_cycle(lists:delete(lists:nth(1, Candidates), Edges), N) of
        true ->
            lists:nth(1, Candidates);
        false ->
            lists:nth(2, Candidates)
    end.

cycle_case(Edges, N) ->
    for(Edges, N, 1).

for(Edges, N, I) ->
    case check_cycle(lists:delete(lists:nth(I, Edges), Edges), N) of
        true ->
            lists:nth(I, Edges);
        false ->
            for(Edges, N, I + 1)
    end.

check_cycle(Edges, N) ->
    check_cycle(Edges, N, lists:seq(1, N), []).

check_cycle(Edges, N, Unvisited, Visited) ->
    case Unvisited of
        [] ->
            true;
        [StartNode | RestUnvisited] ->
            {Reachable, NewUnvisited} = dfs(Edges, StartNode, [StartNode], [], Unvisited),
            check_cycle(Edges, N, NewUnvisited, Visited ++ Reachable)
    end.

dfs(Edges, Node, [Node | Stack], Visited, Unvisited) ->
    case lists:member(Node, Visited) of
        true ->
            {Visited, Unvisited};
        false ->
            Neighbors = [V || {U, V} <- Edges, U == Node],
            case Neighbors of
                [] ->
                    {Visited ++ [Node], lists:delete(Node, Unvisited)};
                _ ->
                    dfs(Edges, lists:nth(1, Neighbors), Neighbors ++ Stack, Visited ++ [Node], lists:delete(Node, Unvisited))
            end
    end;
dfs(Edges, _, [], Visited, Unvisited) ->
    {Visited, Unvisited}.