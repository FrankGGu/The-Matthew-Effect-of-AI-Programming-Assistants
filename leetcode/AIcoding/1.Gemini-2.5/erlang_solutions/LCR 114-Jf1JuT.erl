-module(solution).
-export([alienOrder/1]).

alienOrder(Words) ->
    % 1. Initialize data structures
    AllChars = sets:new(),
    Graph = maps:new(),
    InDegree = maps:new(),

    % Populate AllChars, initialize InDegree and Graph for all chars
    % Note: maps:put will overwrite if a key already exists, which is fine for initialization
    % as we want each char to start with 0 in-degree and an empty set of neighbors.
    lists:foreach(fun(Word) ->
        lists:foreach(fun(Char) ->
            AllChars = sets:add_element(Char, AllChars),
            InDegree = maps:put(Char, 0, InDegree),
            Graph = maps:put(Char, sets:new(), Graph)
        end, Word)
    end, Words),

    % 2. Build graph and in-degrees by comparing adjacent words
    % Keep track of edges already added to avoid double counting in-degrees
    EdgesAdded = sets:new(),

    {UpdatedGraph, UpdatedInDegree, IsInvalid} = build_graph_and_indegree(Words, Graph, InDegree, EdgesAdded),

    if IsInvalid == true ->
        ""; % Invalid order detected, return empty string
    true ->
        % 3. Topological Sort (Kahn's algorithm)
        Queue = queue:new(),
        InitialQueue = sets:fold(fun(Char, QAcc) ->
            case maps:get(Char, UpdatedInDegree) of
                0 -> queue:in(Char, QAcc);
                _ -> QAcc
            end
        end, Queue, AllChars),

        ResultList = [], % Accumulate result in reverse order
        {FinalResultList, _FinalInDegree, _FinalQueue} = topological_sort_loop(InitialQueue, UpdatedGraph, UpdatedInDegree, ResultList),

        % 4. Validate result
        if length(FinalResultList) == sets:size(AllChars) ->
            lists:reverse(FinalResultList); % ResultList was built in reverse
        true ->
            "" % Cycle detected or graph inconsistent (not all characters could be ordered)
        end
    end.

build_graph_and_indegree([], Graph, InDegree, _EdgesAdded) ->
    {Graph, InDegree, false};
build_graph_and_indegree([_Word], Graph, InDegree, _EdgesAdded) ->
    {Graph, InDegree, false}; % Only one word, no comparisons possible
build_graph_and_indegree([W1, W2 | Rest], Graph, InDegree, EdgesAdded) ->
    {NewGraph, NewInDegree, NewEdgesAdded, IsInvalid} = add_edges_between_words(W1, W2, Graph, InDegree, EdgesAdded),
    if IsInvalid == true ->
        {NewGraph, NewInDegree, true}; % Propagate invalid state immediately
    true ->
        build_graph_and_indegree([W2 | Rest], NewGraph, NewInDegree, NewEdgesAdded)
    end.

add_edges_between_words(W1, W2, Graph, InDegree, EdgesAdded) ->
    Len1 = length(W1),
    Len2 = length(W2),
    MinLen = min(Len1, Len2),

    add_edges_loop(W1, W2, 0, MinLen, Len1, Len2, Graph, InDegree, EdgesAdded).

add_edges_loop(W1, W2, Idx, MinLen, Len1, Len2, Graph, InDegree, EdgesAdded) ->
    if Idx == MinLen ->
        % If all common prefix characters are the same
        % Check for invalid order like ["abc", "ab"] where "abc" comes before "ab"
        if Len1 > Len2 ->
            {Graph, InDegree, EdgesAdded, true}; % Invalid order
        true ->
            {Graph, InDegree, EdgesAdded, false} % Valid, no new edge from this pair
        end;
    true ->
        C1 = lists:nth(Idx + 1, W1), % Erlang lists are 1-indexed for nth
        C2 = lists:nth(Idx + 1, W2),

        if C1 /= C2 ->
            Edge = {C1, C2},
            if sets:is_element(Edge, EdgesAdded) ->
                {Graph, InDegree, EdgesAdded, false}; % Edge already processed, no change
            true ->
                NewEdgesAdded = sets:add_element(Edge, EdgesAdded),

                CurrentNeighbors = maps:get(C1, Graph),
                NewNeighbors = sets:add_element(C2, CurrentNeighbors),
                NewGraph = maps:put(C1, NewNeighbors, Graph),

                CurrentInDegreeC2 = maps:get(C2, InDegree),
                NewInDegreeC2 = CurrentInDegreeC2 + 1,
                NewInDegree = maps:put(C2, NewInDegreeC2, InDegree),

                {NewGraph, NewInDegree, NewEdgesAdded, false} % New edge added
            end;
        true ->
            % Characters are same, continue to next character in the words
            add_edges_loop(W1, W2, Idx + 1, MinLen, Len1, Len2, Graph, InDegree, EdgesAdded)
        end
    end.

topological_sort_loop(Queue, Graph, InDegree, ResultList) ->
    case queue:out(Queue) of
        {empty, _} ->
            {ResultList, InDegree, Queue}; % Queue is empty, sorting finished
        {value, Char, NewQueue} ->
            NewResultList = [Char | ResultList], % Add char to result (in reverse order)

            Neighbors = maps:get(Char, Graph), % Get all characters that Char points to
            {NextInDegree, NextQueue} = sets:fold(fun(Neighbor, {AccInDegree, AccQueue}) ->
                CurrentNeighborInDegree = maps:get(Neighbor, AccInDegree),
                DecrementedInDegree = CurrentNeighborInDegree - 1,
                NewAccInDegree = maps:put(Neighbor, DecrementedInDegree, AccInDegree),

                if DecrementedInDegree == 0 ->
                    {NewAccInDegree, queue:in(Neighbor, AccQueue)}; % If in-degree becomes 0, add to queue
                true ->
                    {NewAccInDegree, AccQueue}
                end
            end, {InDegree, NewQueue}, Neighbors),

            topological_sort_loop(NextQueue, Graph, NextInDegree, NewResultList)
    end.