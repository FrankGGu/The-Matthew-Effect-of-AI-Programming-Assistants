-module(solution).
-export([longest_cycle/1]).

longest_cycle(Graph) ->
    N = length(Graph),
    Visited = lists:duplicate(N, false),
    RecStack = lists:duplicate(N, false),
    longest_cycle_helper(Graph, Visited, RecStack, 0).

longest_cycle_helper(_, _, _, MaxCycle) when MaxCycle > 0 ->
    MaxCycle;
longest_cycle_helper(Graph, Visited, RecStack, MaxCycle) ->
    lists:foldl(fun(Index, Acc) ->
        case Visited[Index] of
            false -> 
                case dfs(Graph, Index, Visited, RecStack, 0, []) of
                    {CycleLength, HasCycle} when HasCycle -> 
                        max(Acc, CycleLength);
                    _ -> 
                        Acc
                end;
            _ -> 
                Acc
        end
    end, MaxCycle, lists:seq(0, length(Graph) - 1)).

dfs(Graph, Index, Visited, RecStack, Depth, Path) ->
    Visited1 = lists:update_at(Index, fun(_) -> true end, Visited),
    RecStack1 = lists:update_at(Index, fun(_) -> true end, RecStack),
    Neighbors = lists:nth(Index + 1, Graph),
    lists:foldl(fun(Neighbor, {AccDepth, HasCycle}) ->
        case lists:nth(Neighbor + 1, Visited1) of
            false ->
                dfs(Graph, Neighbor, Visited1, RecStack1, AccDepth + 1, [Neighbor | Path]);
            true ->
                if 
                    lists:nth(Neighbor + 1, RecStack1) -> 
                        {AccDepth + 1 - lists:keyfind(Neighbor, 1, lists:zip(Path, lists:seq(0, length(Path) - 1))), true};
                    true -> 
                        {AccDepth, HasCycle}
                end
        end
    end, {Depth, false}, Neighbors).