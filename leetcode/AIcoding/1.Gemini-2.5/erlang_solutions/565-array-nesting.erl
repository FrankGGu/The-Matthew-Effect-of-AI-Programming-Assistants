-module(solution).
-export([array_nesting/1]).

array_nesting(A_list) ->
    N = length(A_list),
    A = array:from_list(A_list), % Convert input list to Erlang array for efficient random access

    % Visited array, initialized to false for all elements
    Visited = array:new(N, {default, false}),

    % Start the main loop to find the maximum cycle length
    find_max_length(0, N, A, Visited, 0).

find_max_length(K, N, A, Visited, MaxLen) when K < N ->
    case array:get(K, Visited) of
        true ->
            % K has already been visited as part of another cycle, skip
            find_max_length(K + 1, N, A, Visited, MaxLen);
        false ->
            % Start a new cycle traversal from K
            {CurrentLen, NewVisited} = traverse_cycle(K, A, Visited, 0),
            NewMaxLen = max(MaxLen, CurrentLen),
            find_max_length(K + 1, N, A, NewVisited, NewMaxLen)
    end;
find_max_length(_K, _N, _A, _Visited, MaxLen) ->
    % All K processed, return MaxLen
    MaxLen.

traverse_cycle(CurrentNode, A, Visited, CurrentLen) ->
    case array:get(CurrentNode, Visited) of
        true ->
            % We've hit an already visited node, meaning the cycle is complete.
            % The current CurrentLen is the length of this cycle.
            {CurrentLen, Visited};
        false ->
            % Mark current node as visited for this traversal
            NewVisited = array:set(CurrentNode, true, Visited),
            % Move to the next node in the cycle
            NextNode = array:get(CurrentNode, A),
            traverse_cycle(NextNode, A, NewVisited, CurrentLen + 1)
    end.