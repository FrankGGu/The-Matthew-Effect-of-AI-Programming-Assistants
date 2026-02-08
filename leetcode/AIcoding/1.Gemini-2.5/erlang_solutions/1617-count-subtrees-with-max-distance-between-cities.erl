-module(solution).
-export([countSubtreesWithMaxDistance/2]).

countSubtreesWithMaxDistance(N, Edges) ->
    Adj = make_adj_list(N, Edges),

    % Counts array: index D stores count for distance D.
    % Size N, so indices 0 to N-1.
    % We need counts for distances 1 to N-1.
    Counts = array:from_list(lists:duplicate(N, 0)),

    % Iterate through all possible non-empty subsets of cities (bitmasks).
    % A subset must have at least 2 cities to have a max distance >= 1.
    % Masks from 1 to 2^N - 1.
    FinalCounts = lists:foldl(fun(Mask, AccCounts) ->
        CitiesInSubset = get_cities_from_mask(N, Mask),
        case length(CitiesInSubset) of
            L when L < 2 -> % Subsets with 0 or 1 city have max distance 0.
                AccCounts;
            _ ->
                case is_connected_and_max_dist(N, Adj, CitiesInSubset) of
                    {true, MaxDist} when MaxDist >= 1 ->
                        % Increment count for MaxDist
                        array:set(MaxDist, array:get(MaxDist, AccCounts) + 1, AccCounts);
                    _ ->
                        AccCounts
                end
        end
    end, Counts, lists:seq(1, (1 bsl N) - 1)),

    % Convert the relevant part of the array to a list for the result.
    % Result[i] is count for distance i+1.
    % So, we need Counts[1], Counts[2], ..., Counts[N-1].
    [array:get(I, FinalCounts) || I <- lists:seq(1, N-1)].

make_adj_list(N, Edges) ->
    Adj = array:from_list(lists:duplicate(N + 1, [])), % Initialize with empty lists
    lists:foldl(fun([U, V], AccAdj) ->
        AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
        array:set(V, [U | array:get(V, AccAdj)], AccAdj1)
    end, Adj, Edges).

get_cities_from_mask(N, Mask) ->
    lists:foldl(fun(I, Acc) ->
        case (Mask bsr (I-1)) band 1 of
            1 -> [I | Acc];
            _ -> Acc
        end
    end, [], lists:seq(1, N)).

is_connected_and_max_dist(N, Adj, CitiesInSubset) ->
    SubsetSet = sets:from_list(CitiesInSubset),
    SubsetSize = sets:size(SubsetSet),

    % This function is called only for SubsetSize >= 2 by the main loop.
    % So, we can directly proceed with connectivity check.
    StartCity = hd(CitiesInSubset),
    {ConnectedCount, _VisitedSet} = bfs_connectivity(Adj, SubsetSet, StartCity),

    case ConnectedCount == SubsetSize of
        false -> {false, 0}; % Not connected
        true ->
            % If connected, calculate the overall max distance within the subset
            MaxOverallDist = calculate_max_distance_in_subset(Adj, CitiesInSubset, SubsetSet),
            {true, MaxOverallDist}
    end.

bfs_connectivity(Adj, SubsetSet, StartCity) ->
    Queue = queue:new(),
    Queue1 = queue:in(StartCity, Queue),
    Visited = sets:add_element(StartCity, sets:new()),
    bfs_connectivity_loop(Adj, SubsetSet, Queue1, Visited).

bfs_connectivity_loop(Adj, SubsetSet, Q, Visited) ->
    case queue:out(Q) of
        {{value, CurrentCity}, QRest} ->
            Neighbors = array:get(CurrentCity, Adj),
            {NewQ, NewVisited} = lists:foldl(fun(Neighbor, {AccQ, AccVisited}) ->
                % Only consider neighbors that are in the subset and not yet visited
                case sets:is_element(Neighbor, SubsetSet) andalso not sets:is_element(Neighbor, AccVisited) of
                    true ->
                        {queue:in(Neighbor, AccQ), sets:add_element(Neighbor, AccVisited)};
                    false ->
                        {AccQ, AccVisited}
                end
            end, {QRest, Visited}, Neighbors),
            bfs_connectivity_loop(Adj, SubsetSet, NewQ, NewVisited);
        {empty, _} ->
            {sets:size(Visited), Visited}
    end.

calculate_max_distance_in_subset(Adj, CitiesInSubset, SubsetSet) ->
    lists:foldl(fun(StartNode, AccMaxDist) ->
        % Run BFS from StartNode to find distances to all other nodes in SubsetSet
        MaxDistFromStartNode = bfs_max_dist_from_node(Adj, SubsetSet, StartNode),
        max(AccMaxDist, MaxDistFromStartNode)
    end, 0, CitiesInSubset).

bfs_max_dist_from_node(Adj, SubsetSet, StartNode) ->
    Queue = queue:new(),
    Queue1 = queue:in({StartNode, 0}, Queue), % {City, Distance}
    Visited = sets:add_element(StartNode, sets:new()),
    bfs_max_dist_from_node_loop(Adj, SubsetSet, Queue1, Visited, 0).

bfs_max_dist_from_node_loop(Adj, SubsetSet, Q, Visited, CurrentMaxDist) ->
    case queue:out(Q) of
        {{value, {CurrentCity, Dist}}, QRest} ->
            Neighbors = array:get(CurrentCity, Adj),
            {NewQ, NewVisited, NewMaxDist} = lists:foldl(fun(Neighbor, {AccQ, AccVisited, AccMaxDist}) ->
                case sets:is_element(Neighbor, SubsetSet) andalso not sets:is_element(Neighbor, AccVisited) of
                    true ->
                        {queue:in({Neighbor, Dist + 1}, AccQ),
                         sets:add_element(Neighbor, AccVisited),
                         max(AccMaxDist, Dist + 1)};
                    false ->
                        {AccQ, AccVisited, AccMaxDist}
                end
            end, {QRest, Visited, CurrentMaxDist}, Neighbors),
            bfs_max_dist_from_node_loop(Adj, SubsetSet, NewQ, NewVisited, NewMaxDist);
        {empty, _} ->
            CurrentMaxDist
    end.