-module(maximum_employees).
-export([maximum_invitations/1]).

maximum_invitations(Preferences) ->
    N = length(Preferences),
    {Adj, RevAdj} = build_graph(Preferences),
    {CycleLengths, NonCycleNodes} = find_cycles(Adj, N),
    MaxCycleLength = lists:max(CycleLengths),
    MaxNonCycle = calculate_max_non_cycle(RevAdj, NonCycleNodes),
    max(MaxCycleLength, MaxNonCycle).

build_graph(Preferences) ->
    N = length(Preferences),
    Adj = lists:map(fun(X) -> [] end, lists:seq(1, N)),
    RevAdj = lists:map(fun(X) -> [] end, lists:seq(1, N)),
    build_graph_helper(Preferences, 1, Adj, RevAdj).

build_graph_helper([], _, Adj, RevAdj) ->
    {Adj, RevAdj};
build_graph_helper([Pref | Rest], Index, Adj, RevAdj) ->
    Adj1 = lists:nth(Index, Adj),
    Adj2 = lists:keyreplace(Index, 1, Adj, {Index, [Pref] ++ Adj1}),
    RevAdj1 = lists:nth(Pref, RevAdj),
    RevAdj2 = lists:keyreplace(Pref, 1, RevAdj, {Pref, [Index] ++ RevAdj1}),
    build_graph_helper(Rest, Index + 1, Adj2, RevAdj2).

find_cycles(Adj, N) ->
    Visited = lists:map(fun(X) -> false end, lists:seq(1, N)),
    {CycleLengths, NonCycleNodes, _} = find_cycles_helper(Adj, 1, N, [], [], Visited),
    {CycleLengths, NonCycleNodes}.

find_cycles_helper(_, Index, N, CycleLengths, NonCycleNodes, Visited) when Index > N ->
    {CycleLengths, NonCycleNodes, Visited};
find_cycles_helper(Adj, Index, N, CycleLengths, NonCycleNodes, Visited) ->
    case lists:nth(Index, Visited) of
        true ->
            find_cycles_helper(Adj, Index + 1, N, CycleLengths, NonCycleNodes, Visited);
        false ->
            {NewCycleLengths, NewNonCycleNodes, NewVisited} = find_cycle(Adj, Index, [], CycleLengths, NonCycleNodes, Visited),
            find_cycles_helper(Adj, Index + 1, N, NewCycleLengths, NewNonCycleNodes, NewVisited)
    end.

find_cycle(Adj, Node, Path, CycleLengths, NonCycleNodes, Visited) ->
    NewVisited = lists:keyreplace(Node, 1, Visited, {Node, true}),
    NextNodes = lists:nth(Node, Adj),
    case NextNodes of
        [Next] ->
            case lists:member(Next, Path) of
                true ->
                    CycleLength = length(Path) + 1,
                    NewCycleLengths = [CycleLength | CycleLengths],
                    NewNonCycleNodes = NonCycleNodes,
                    {NewCycleLengths, NewNonCycleNodes, NewVisited};
                false ->
                    find_cycle(Adj, Next, [Node | Path], CycleLengths, NonCycleNodes, NewVisited)
            end;
        _ ->
            {CycleLengths, NonCycleNodes, Visited}
    end.

calculate_max_non_cycle(RevAdj, NonCycleNodes) ->
    N = length(RevAdj),
    Max = 0,
    calculate_max_non_cycle_helper(RevAdj, 1, N, NonCycleNodes, Max).

calculate_max_non_cycle_helper(_, Index, N, _, Max) when Index > N ->
    Max;
calculate_max_non_cycle_helper(RevAdj, Index, N, NonCycleNodes, Max) ->
    case lists:member(Index, NonCycleNodes) of
        true ->
            calculate_max_non_cycle_helper(RevAdj, Index + 1, N, NonCycleNodes, Max);
        false ->
            NextNodes = lists:nth(Index, RevAdj),
            case NextNodes of
                [Next1, Next2] ->
                    Max1 = get_max_path(RevAdj, Next1, [Index], []),
                    Max2 = get_max_path(RevAdj, Next2, [Index], []),
                    calculate_max_non_cycle_helper(RevAdj, Index + 1, N, NonCycleNodes, Max + Max1 + Max2 + 2);
                _ ->
                    calculate_max_non_cycle_helper(RevAdj, Index + 1, N, NonCycleNodes, Max)
            end
    end.

get_max_path(RevAdj, Node, Path, MaxPath) ->
    NextNodes = lists:nth(Node, RevAdj),
    case NextNodes of
        [] ->
            length(Path);
        _ ->
             lists:max([get_max_path(RevAdj, Next, [Node | Path], MaxPath) || Next <- NextNodes, not lists:member(Next, Path)])
    end.