-module(solution).
-export([min_cost_walk/3]).

init_dsu(N) ->
    Parents = array:from_list(lists:seq(0, N-1)),
    ComponentAnds = array:from_list(lists:duplicate(N, (1 bsl 30) - 1)),
    #{parent => Parents, component_and => ComponentAnds}.

find(I, DSU) ->
    Parents = maps:get(parent, DSU),
    P_I = array:get(I, Parents),
    if P_I == I ->
        {I, DSU};
    else
        {Root, UpdatedDSU} = find(P_I, DSU),
        % Path compression: update parent of I to Root
        NewParents = array:set(I, Root, maps:get(parent, UpdatedDSU)),
        {Root, maps:put(parent, NewParents, UpdatedDSU)}
    end.

union(U, V, W, DSU) ->
    {RootU, DSU1} = find(U, DSU),
    {RootV, DSU2} = find(V, DSU1), % Use DSU1 to ensure updates from find(U) are propagated
    if RootU /= RootV ->
        Parents = maps:get(parent, DSU2),
        ComponentAnds = maps:get(component_and, DSU2),

        ComponentAndU = array:get(RootU, ComponentAnds),
        ComponentAndV = array:get(RootV, ComponentAnds),

        % The component_and for the new merged component is the bitwise AND
        % of the component_and values of the two merged components and the edge weight W.
        NewComponentAndU = ComponentAndU band ComponentAndV band W,

        NewParents = array:set(RootV, RootU, Parents), % Make RootU parent of RootV
        NewComponentAnds = array:set(RootU, NewComponentAndU, ComponentAnds), % Update component_and for new root
        maps:put(parent, NewParents, maps:put(component_and, NewComponentAnds, DSU2));
    else
        DSU2 % Already in the same component, DSU state unchanged
    end.

get_component_and(Root, DSU) ->
    ComponentAnds = maps:get(component_and, DSU),
    array:get(Root, ComponentAnds).

min_cost_walk(N, Edges, Queries) ->
    MaxPossibleAndVal = (1 bsl 30) - 1, % Maximum possible AND value (all bits set up to 2^30-1)
    NumQueries = length(Queries),

    % Store queries with their original indices
    IndexedQueries = lists:zip(Queries, lists:seq(0, NumQueries-1)),

    % Initialize answers array with 0s
    Answers = array:from_list(lists:duplicate(NumQueries, 0)),

    % Handle queries where start == end node: cost is MaxPossibleAndVal
    InitialAnswers = lists:foldl(fun({[S, T], Idx}, AccAnswers) ->
        if S == T ->
            array:set(Idx, MaxPossibleAndVal, AccAnswers);
        true ->
            AccAnswers
        end
    end, Answers, IndexedQueries),

    % Iterate bits from MSB (29) down to LSB (0)
    FinalAnswers = lists:foldl(fun(K, CurrentAnswers) ->
        % Initialize DSU for the current bit K
        DSU = init_dsu(N),

        % Process edges: union nodes if the edge weight has bit K set
        DSUWithEdges = lists:foldl(fun([U, V, W], AccDSU) ->
            if (W band (1 bsl K)) == (1 bsl K) -> % Check if edge weight W has bit K set
                union(U, V, W, AccDSU);
            true ->
                AccDSU
            end
        end, DSU, Edges),

        % Process queries for the current bit K
        lists:foldl(fun({[S, T], Idx}, AccAnswers) ->
            if S == T -> % Already handled, skip
                AccAnswers;
            true ->
                CurrentAns = array:get(Idx, AccAnswers),
                % Only try to set bit K if it's not already set in CurrentAns for this query
                if (CurrentAns band (1 bsl K)) == 0 ->
                    {RootS, DSUWithEdges1} = find(S, DSUWithEdges),
                    {RootT, DSUWithEdges2} = find(T, DSUWithEdges1), % Use DSUWithEdges1 for find(T)

                    if RootS == RootT -> % If S and T are connected in the graph formed by edges with bit K set
                        ComponentAND = get_component_and(RootS, DSUWithEdges2),
                        TargetAND = CurrentAns bor (1 bsl K), % The potential new answer if bit K is set

                        % Check if the component_and (AND of all edges in the component's spanning tree)
                        % is a supermask of TargetAND. This ensures that all edges in any path
                        % within this component satisfy the required bits (CurrentAns's bits + bit K).
                        if (ComponentAND band TargetAND) == TargetAND ->
                            array:set(Idx, TargetAND, AccAnswers);
                        true ->
                            AccAnswers
                        end;
                    true ->
                        AccAnswers
                    end;
                true ->
                    AccAnswers
                end
            end
        end, CurrentAnswers, IndexedQueries)
    end, InitialAnswers, lists:seq(29, 0, -1)), % Iterate K from 29 down to 0

    % Convert 0 to -1 for queries where S != T and no path was found
    lists:map(fun(Ans) ->
        if Ans == 0 -> -1;
        true -> Ans
        end
    end, array:to_list(FinalAnswers)).