-module(solution).
-export([maximum_detonation/1]).

maximum_detonation(Bombs) ->
    N = length(Bombs),
    Adj = build_adjacency(Bombs, N),
    Max = lists:max([dfs(Adj, I, sets:new()) || I <- lists:seq(0, N - 1)]),
    Max.

build_adjacency(Bombs, N) ->
    lists:map(fun(I) ->
        {X1, Y1, R1} = lists:nth(I + 1, Bombs),
        lists:filtermap(fun(J) ->
            {X2, Y2, _} = lists:nth(J + 1, Bombs),
            Dx = X1 - X2,
            Dy = Y1 - Y2,
            case Dx * Dx + Dy * Dy =< R1 * R1 of
                true -> {true, J};
                false -> false
            end
        end, lists:seq(0, N - 1))
    end, lists:seq(0, N - 1)).

dfs(Adj, Node, Visited) ->
    case sets:is_element(Node, Visited) of
        true -> 0;
        false ->
            NewVisited = sets:add_element(Node, Visited),
            1 + lists:sum([dfs(Adj, Neighbor, NewVisited) || Neighbor <- lists:nth(Node + 1, Adj)])
    end.