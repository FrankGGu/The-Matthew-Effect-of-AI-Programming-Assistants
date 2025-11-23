-module(solution).
-export([solve/1]).

solve(Favorite) ->
    N = length(Favorite),
    Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
    CycleNodes = gb_sets:new(),
    MaxCycleLen = 0,
    TwoCycles = [],

    RevAdj = build_rev_adj(N, Favorite),

    {FinalMaxCycleLen, FinalTwoCycles, FinalCycleNodes, _FinalVisited} =
        find_cycles(0, N, Favorite, Visited, CycleNodes, MaxCycleLen, TwoCycles),

    TotalTwoCycleChainsLen = calculate_two_cycle_chains(FinalTwoCycles, RevAdj, FinalCycleNodes),

    max(FinalMaxCycleLen, TotalTwoCycleChainsLen).

build_rev_adj(N, Favorite) ->
    RevAdj = array:new([{size, N}, {fixed, true}, {default, []}]),
    build_rev_adj_loop(0, N, Favorite, RevAdj).

build_rev_adj_loop(I, N, Favorite, RevAdj) when I < N ->
    FavI = lists:nth(I+1, Favorite),
    CurrentList = array:get(FavI, RevAdj),
    NewRevAdj = array:set(FavI, [I | CurrentList], RevAdj),
    build_rev_adj_loop(I+1, N, Favorite, NewRevAdj);
build_rev_adj_loop(_I, _N, _Favorite, RevAdj) ->
    RevAdj.

find_cycles(I, N, Favorite, Visited, CycleNodes, MaxCycleLen, TwoCycles) when I < N ->
    case array:get(I, Visited) of
        true ->
            find_cycles(I+1, N, Favorite, Visited, CycleNodes, MaxCycleLen, TwoCycles);
        false ->
            {NewVisited, Cycle, IsCycle} = traverse_path(I, Favorite, Visited, [], gb_sets:new()),

            case IsCycle of
                true ->
                    CycleLen = length(Cycle),
                    NewCycleNodes = lists:foldl(fun(Node, Acc) -> gb_sets:add(Node, Acc) end, CycleNodes, Cycle),
                    case CycleLen of
                        2 ->
                            NewTwoCycles = [Cycle | TwoCycles],
                            find_cycles(I+1, N, Favorite, NewVisited, NewCycleNodes, MaxCycleLen, NewTwoCycles);
                        _ ->
                            NewMaxCycleLen = max(MaxCycleLen, CycleLen),
                            find_cycles(I+1, N, Favorite, NewVisited, NewCycleNodes, NewMaxCycleLen, TwoCycles)
                    end;
                false ->
                    find_cycles(I+1, N, Favorite, NewVisited, CycleNodes, MaxCycleLen, TwoCycles)
            end
    end;
find_cycles(_I, _N, _Favorite, Visited, CycleNodes, MaxCycleLen, TwoCycles) ->
    {MaxCycleLen, TwoCycles, CycleNodes, Visited}.

traverse_path(Curr, Favorite, Visited, Path, PathSet) ->
    case array:get(Curr, Visited) of
        true ->
            case gb_sets:is_member(Curr, PathSet) of
                true ->
                    ReversedPath = lists:reverse(Path),
                    Cycle = lists:dropwhile(fun(X) -> X /= Curr end, ReversedPath),
                    {Visited, Cycle, true};
                false ->
                    {Visited, [], false}
            end;
        false ->
            NewVisited = array:set(Curr, true, Visited),
            NewPath = [Curr | Path],
            NewPathSet = gb_sets:add(Curr, PathSet),
            Next = lists:nth(Curr+1, Favorite),
            traverse_path(Next, Favorite, NewVisited, NewPath, NewPathSet)
    end.

calculate_two_cycle_chains(TwoCycles, RevAdj, CycleNodes) ->
    lists:foldl(fun(Cycle, Acc) ->
        [U, V] = Cycle,
        MaxDepthU = bfs_chain(U, V, RevAdj, CycleNodes),
        MaxDepthV = bfs_chain(V, U, RevAdj, CycleNodes),
        Acc + (MaxDepthU + 1) + (MaxDepthV + 1)
    end, 0, TwoCycles).

bfs_chain(StartNode, ExcludeNode, RevAdj, CycleNodes) ->
    Q = queue:new(),
    Q1 = queue:in({StartNode, 0}, Q),
    VisitedForChain = gb_sets:from_list([StartNode, ExcludeNode]),
    bfs_chain_loop(Q1, VisitedForChain, 0, RevAdj, CycleNodes).

bfs_chain_loop(Q, VisitedForChain, MaxDepth, RevAdj, CycleNodes) ->
    case queue:out(Q) of
        {{value, {CurrNode, CurrDepth}}, NewQ} ->
            NewMaxDepth = max(MaxDepth, CurrDepth),
            Predecessors = array:get(CurrNode, RevAdj),
            {FinalQ, FinalVisitedForChain} = lists:foldl(fun(PrevNode, {AccQ, AccVisited}) ->
                case gb_sets:is_member(PrevNode, AccVisited) orelse gb_sets:is_member(PrevNode, CycleNodes) of
                    true -> {AccQ, AccVisited};
                    false ->
                        {queue:in({PrevNode, CurrDepth + 1}, AccQ), gb_sets:add(PrevNode, AccVisited)}
                end
            end, {NewQ, VisitedForChain}, Predecessors),
            bfs_chain_loop(FinalQ, FinalVisitedForChain, NewMaxDepth, RevAdj, CycleNodes);
        empty ->
            MaxDepth
    end.