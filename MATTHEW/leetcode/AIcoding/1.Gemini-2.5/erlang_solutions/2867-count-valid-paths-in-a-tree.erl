-module(solution).
-export([count_valid_paths/2]).

sieve(N) ->
    IsPrime = array:new(N + 1, {default, true}),
    IsPrime1 = array:set(1, false, IsPrime), % 1 is not prime
    sieve_loop(2, N, IsPrime1).

sieve_loop(P, N, IsPrime) when P * P =< N ->
    case array:get(P, IsPrime) of
        true ->
            MarkedIsPrime = mark_multiples(P * P, P, N, IsPrime);
        false ->
            MarkedIsPrime = IsPrime
    end,
    sieve_loop(P + 1, N, MarkedIsPrime);
sieve_loop(_P, _N, IsPrime) ->
    IsPrime.

mark_multiples(I, P, N, IsPrime) when I =< N ->
    MarkedIsPrime = array:set(I, false, IsPrime),
    mark_multiples(I + P, P, N, MarkedIsPrime);
mark_multiples(_I, _P, _N, IsPrime) ->
    IsPrime.

build_adj(N, Edges) ->
    Adj = array:new(N + 1, {default, []}),
    lists:foldl(fun([U, V], CurrentAdj) ->
        Adj1 = array:set(U, [V | array:get(U, CurrentAdj)], CurrentAdj),
        array:set(V, [U | array:get(V, Adj1)], Adj1)
    end, Adj, Edges).

find_non_prime_components(N, IsPrime, Adj) ->
    ComponentId = array:new(N + 1, {default, 0}), % 0 means unvisited
    ComponentSizes = array:new(N + 1, {default, 0}), % Store sizes by component ID
    {_FinalComponentId, FinalComponentIdArray, FinalComponentSizes} =
        find_non_prime_components_loop(1, N, IsPrime, Adj, 1, ComponentId, ComponentSizes),
    {FinalComponentIdArray, FinalComponentSizes}.

find_non_prime_components_loop(I, N, IsPrime, Adj, CurrentCompId, ComponentIdArray, ComponentSizesArray) when I =< N ->
    case array:get(I, IsPrime) of
        false -> % I is non-prime
            case array:get(I, ComponentIdArray) of
                0 -> % Not yet visited/assigned to a component
                    {NewComponentIdArray, Size} = bfs_component(I, IsPrime, Adj, CurrentCompId, ComponentIdArray),
                    NewComponentSizesArray = array:set(CurrentCompId, Size, ComponentSizesArray),
                    find_non_prime_components_loop(I + 1, N, IsPrime, Adj, CurrentCompId + 1, NewComponentIdArray, NewComponentSizesArray);
                _ -> % Already part of a component
                    find_non_prime_components_loop(I + 1, N, IsPrime, Adj, CurrentCompId, ComponentIdArray, ComponentSizesArray)
            end;
        true -> % I is prime, skip
            find_non_prime_components_loop(I + 1, N, IsPrime, Adj, CurrentCompId, ComponentIdArray, ComponentSizesArray)
    end;
find_non_prime_components_loop(_I, _N, _IsPrime, _Adj, CurrentCompId, ComponentIdArray, ComponentSizesArray) ->
    {CurrentCompId, ComponentIdArray, ComponentSizesArray}.

bfs_component(StartNode, IsPrime, Adj, CompId, ComponentIdArray) ->
    Q = queue:from_list([StartNode]),
    Visited1 = array:set(StartNode, CompId, ComponentIdArray),
    bfs_component_loop(Q, IsPrime, Adj, CompId, Visited1, 1).

bfs_component_loop(Q, IsPrime, Adj, CompId, ComponentIdArray, Size) ->
    case queue:out(Q) of
        {{value, U}, NewQ} ->
            Neighbors = array:get(U, Adj),
            {NextQ, NextComponentIdArray, NextSize} = lists:foldl(fun(V, {AccQ, AccComponentIdArray, AccSize}) ->
                case array:get(V, IsPrime) of
                    false -> % V is non-prime
                        case array:get(V, AccComponentIdArray) of
                            0 -> % V not yet visited
                                NewAccComponentIdArray = array:set(V, CompId, AccComponentIdArray),
                                {queue:in(V, AccQ), NewAccComponentIdArray, AccSize + 1};
                            _ -> % V already visited
                                {AccQ, AccComponentIdArray, AccSize}
                        end;
                    true -> % V is prime
                        {AccQ, AccComponentIdArray, AccSize}
                end
            end, {NewQ, ComponentIdArray, Size}, Neighbors),
            bfs_component_loop(NextQ, IsPrime, Adj, CompId, NextComponentIdArray, NextSize);
        empty ->
            {ComponentIdArray, Size}
    end.

count_valid_paths(N, Edges) ->
    IsPrime = sieve(N),
    Adj = build_adj(N, Edges),
    {ComponentIdMap, ComponentSizesMap} = find_non_prime_components(N, IsPrime, Adj),

    TotalPaths = count_paths_for_primes(1, N, IsPrime, Adj, ComponentIdMap, ComponentSizesMap, 0),
    TotalPaths.

count_paths_for_primes(I, N, IsPrime, Adj, ComponentIdMap, ComponentSizesMap, AccTotalPaths) when I =< N ->
    case array:get(I, IsPrime) of
        true -> % I is a prime node
            AdjacentCompIdsSet = gb_sets:new(),
            Neighbors = array:get(I, Adj),
            FilteredAdjacentCompIdsSet = lists:foldl(fun(V, CurrentSet) ->
                case array:get(V, IsPrime) of
                    false -> % V is non-prime
                        CompId = array:get(V, ComponentIdMap),
                        gb_sets:add(CompId, CurrentSet);
                    true -> % V is prime
                        CurrentSet
                end
            end, AdjacentCompIdsSet, Neighbors),

            NonPrimeCountsFromNeighbors = lists:map(fun(CompId) ->
                array:get(CompId, ComponentSizesMap)
            end, gb_sets:to_list(FilteredAdjacentCompIdsSet)),

            SumOfCounts = lists:sum(NonPrimeCountsFromNeighbors),
            SumOfSquares = lists:sum(lists:map(fun(C) -> C * C end, NonPrimeCountsFromNeighbors)),

            CurrentPathsForI = SumOfCounts + (SumOfCounts * SumOfCounts - SumOfSquares) div 2,
            count_paths_for_primes(I + 1, N, IsPrime, Adj, ComponentIdMap, ComponentSizesMap, AccTotalPaths + CurrentPathsForI);
        false -> % I is non-prime, skip
            count_paths_for_primes(I + 1, N, IsPrime, Adj, ComponentIdMap, ComponentSizesMap, AccTotalPaths)
    end;
count_paths_for_primes(_I, _N, _IsPrime, _Adj, _ComponentIdMap, _ComponentSizesMap, AccTotalPaths) ->
    AccTotalPaths.