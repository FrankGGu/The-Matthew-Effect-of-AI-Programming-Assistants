-module(solution).
-export([sequenceReconstruction/2]).

sequenceReconstruction(Org, Seqs) ->
    N = length(Org),

    % Handle edge cases for empty Org or Seqs
    case {N, Seqs} of
        {0, []} -> true; % Empty Org can be reconstructed from empty Seqs
        {0, _} -> false; % Org is empty, but Seqs is not (cannot reconstruct an empty sequence from non-empty subsequences)
        {_, []} -> false; % Org is not empty, but Seqs is empty (cannot reconstruct a non-empty sequence from no subsequences)
        _ -> ok
    end,

    % Create a map for quick lookup of Org elements.
    % This is crucial for filtering out elements in seqs that are not part of Org.
    OrgMap = maps:from_list([{X, true} || X <- Org]),

    % Initialize Graph (adjacency list) and InDegree map for all elements in Org.
    % Graph: #{Node => set_of_Neighbors}
    % InDegree: #{Node => Count_of_Incoming_Edges}
    Graph = maps:from_list([{I, sets:new()} || I <- Org]),
    InDegree = maps:from_list([{I, 0} || I <- Org]),

    % Build graph and in-degrees, and simultaneously check for invalid elements in seqs.
    % If any element in a subsequence is not present in Org, the reconstruction is impossible.
    {FinalGraph, FinalInDegree, ValidElements} = lists:foldl(
        fun(Seq, {CurrentGraph, CurrentInDegree, CurrentValid}) ->
            case CurrentValid of
                false -> {CurrentGraph, CurrentInDegree, false}; % Propagate invalid state if already found
                true ->
                    case Seq of
                        [] -> {CurrentGraph, CurrentInDegree, true}; % Empty subsequence, no edges to add
                        [H | T] ->
                            % Check if the first element of the subsequence is in Org
                            case maps:is_key(H, OrgMap) of
                                false -> {CurrentGraph, CurrentInDegree, false}; % Element not in Org
                                true ->
                                    % Process the rest of the elements in the subsequence to build edges
                                    process_seq_elements(H, T, CurrentGraph, CurrentInDegree, OrgMap)
                            end
                    end
            end
        end,
        {Graph, InDegree, true}, % Initial accumulator: {Graph, InDegree, ValidElements_Flag}
        Seqs
    ),

    case ValidElements of
        false -> false; % An element in 'seqs' was not found in 'org'
        true ->
            % 3. Perform Topological Sort using Kahn's algorithm
            Q = queue:new(),
            % Initialize the queue with all nodes that have an in-degree of 0
            InitialQ = maps:fold(
                fun(Node, Count, AccQ) ->
                    case Count == 0 of
                        true -> queue:in(Node, AccQ);
                        false -> AccQ
                    end
                end,
                Q,
                FinalInDegree
            ),

            % Execute the topological sort
            {ReconstructedSeq, _FinalQ, _FinalInDegreeMap, Possible} = topo_sort(InitialQ, FinalGraph, FinalInDegree, []),

            case Possible of
                false -> false; % Not uniquely reconstructible (multiple choices at some point)
                true ->
                    % 4. Final check:
                    % - The reconstructed sequence must be identical to Org.
                    % - The length of the reconstructed sequence must be equal to N (meaning all nodes were processed, no cycles or missing nodes).
                    lists:reverse(ReconstructedSeq) == Org andalso length(ReconstructedSeq) == N
            end
    end.

process_seq_elements(Prev, [], Graph, InDegree, _OrgMap) ->
    {Graph, InDegree, true}; % End of sequence, no more elements to process
process_seq_elements(Prev, [Current | Rest], Graph, InDegree, OrgMap) ->
    case maps:is_key(Current, OrgMap) of
        false -> {Graph, InDegree, false}; % Current element is not in Org
        true ->
            % Add an edge from Prev to Current
            NewNeighbors = sets:add_element(Current, maps:get(Prev, Graph)),
            NewGraph = maps:put(Prev, NewNeighbors, Graph),
            % Increment the in-degree of Current
            NewInDegree = maps:update_with(Current, fun(Count) -> Count + 1 end, 1, InDegree),
            % Continue processing the rest of the sequence
            process_seq_elements(Current, Rest, NewGraph, NewInDegree, OrgMap)
    end.

topo_sort(Q, Graph, InDegree, AccSeq) ->
    case queue:is_empty(Q) of
        true ->
            % If the queue is empty, we have processed all reachable nodes.
            % 'Possible' flag indicates if the sort was unique up to this point.
            {AccSeq, Q, InDegree, true};
        false ->
            case queue:len(Q) > 1 of
                true ->
                    % If there's more than one node with in-degree 0,
                    % the sequence is not uniquely reconstructible.
                    {AccSeq, Q, InDegree, false};
                false ->
                    % Dequeue the unique node
                    {value, U, Q1} = queue:out(Q),
                    NewAccSeq = [U | AccSeq], % Add node to the reconstructed sequence

                    Neighbors = maps:get(U, Graph, sets:new()), % Get neighbors of U

                    % For each neighbor V of U:
                    % 1. Decrement V's in-degree.
                    % 2. If V's in-degree becomes 0, enqueue V.
                    {NewQ, NewInDegree} = sets:fold(
                        fun(V, {CurrentQ, CurrentInDegreeMap}) ->
                            NewCount = maps:get(V, CurrentInDegreeMap) - 1,
                            UpdatedInDegreeMap = maps:put(V, NewCount, CurrentInDegreeMap),
                            case NewCount == 0 of
                                true -> {queue:in(V, CurrentQ), UpdatedInDegreeMap};
                                false -> {CurrentQ, UpdatedInDegreeMap}
                            end
                        end,
                        {Q1, InDegree},
                        Neighbors
                    ),
                    % Recurse with the updated queue, graph, in-degrees, and sequence
                    topo_sort(NewQ, Graph, NewInDegree, NewAccSeq)
            end
    end.