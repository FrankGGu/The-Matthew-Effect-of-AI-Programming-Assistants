-module(solution).
-export([findItinerary/1]).

findItinerary(Tickets) ->
    % Step 1: Build the adjacency map.
    % Keys are departure airports, values are lists of destination airports.
    % The lists are initially built in reverse order of addition, which is fine
    % as they will be sorted in the next step.
    AdjMap0 = lists:foldl(
        fun([From, To], AccMap) ->
            CurrentList = maps:get(From, AccMap, [])
            maps:put(From, [To | CurrentList], AccMap)
        end,
        maps:new(),
        Tickets
    ),

    % Step 2: Sort all destination lists in ascending lexical order.
    % This is crucial for finding the itinerary with the smallest lexical order.
    % When we pick the head of a destination list, we are selecting the lexically
    % smallest available airport.
    AdjMap = maps:fold(
        fun(Key, Val, AccMap) ->
            maps:put(Key, lists:sort(Val), AccMap)
        end,
        maps:new(),
        AdjMap0
    ),

    % Step 3: Apply Hierholzer's algorithm (iterative version implemented with tail recursion).
    % The algorithm explores the graph, pushing nodes onto an internal stack.
    % When a node has no more outgoing edges, it's popped from the internal stack
    % and added to the path. This builds the final itinerary in the correct order.
    hierholzer("JFK", AdjMap, [], []).

hierholzer(CurrentNode, AdjMap, Stack, Path) ->
    CurrentAdjList = maps:get(CurrentNode, AdjMap, []),
    case CurrentAdjList of
        [] -> % CurrentNode has no more outgoing edges to explore.
            case Stack of
                [] -> % The internal stack is empty, meaning all nodes have been processed.
                      % Add the last CurrentNode to the path and return the final itinerary.
                    [CurrentNode | Path];
                [NextNodeToProcess | RestStack] -> % Pop an airport from the internal stack.
                                                 % CurrentNode is added to the path as it's fully explored.
                    hierholzer(NextNodeToProcess, AdjMap, RestStack, [CurrentNode | Path])
            end;
        _ -> % CurrentNode still has outgoing edges to explore.
            NextDest = hd(CurrentAdjList), % Pick the lexically smallest destination.
            UpdatedAdjList = tl(CurrentAdjList), % Remove the used edge from the list.
            UpdatedAdjMap = maps:put(CurrentNode, UpdatedAdjList, AdjMap), % Update the adjacency map.
            % Continue exploration from NextDest, pushing CurrentNode onto the internal stack
            % to be processed later when NextDest's path is fully explored.
            hierholzer(NextDest, UpdatedAdjMap, [CurrentNode | Stack], Path)
    end.