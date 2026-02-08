-module(solution).
-export([cracking_the_safe/2]).

cracking_the_safe(N, K) ->
    % Initial state: N-1 zeros as a string (list of characters)
    InitialNode = lists:duplicate(N - 1, $0),

    % Visited set to keep track of N-digit sequences already included in the path
    Visited = sets:new(),

    % Result list to accumulate the last digits of the N-digit sequences in reverse order
    Result = [],

    % Call DFS to build the sequence
    % The DFS function returns the final state of Visited set and the Result list
    {_FinalVisited, FinalResult} = dfs(InitialNode, N, K, Visited, Result),

    % The final string is the initial (N-1)-digit prefix followed by the reversed accumulated digits
    string:chars(InitialNode ++ lists:reverse(FinalResult)).

dfs(CurrentNode, N, K, Visited, ResultAcc) ->
    % Iterate through possible next digits from 0 up to K-1.
    % This order (0 to K-1) typically yields the lexicographically smallest De Bruijn sequence.
    lists:foldl(fun(Digit, {AccVisited, AccResult}) ->
        DigitChar = integer_to_list(Digit),

        % Form the N-digit sequence (this is the "edge" in the De Bruijn graph)
        FullSequence = CurrentNode ++ DigitChar,

        % Form the next (N-1)-digit node (this is the "next vertex")
        % If N=1, the nodes are empty strings, and sequences are single digits.
        NextNode = if
                       N == 1 -> []; % If N=1, CurrentNode is [], NextNode is also []
                       true -> string:sub_string(CurrentNode, 2, N - 1) ++ DigitChar
                   end,

        % If this N-digit sequence (edge) has not been visited yet
        case sets:is_element(FullSequence, AccVisited) of
            true ->
                % If already visited, continue with current accumulators
                {AccVisited, AccResult};
            false ->
                % Mark this N-digit sequence as visited
                NewVisited = sets:add(FullSequence, AccVisited),

                % Recursively call DFS for the next node
                {UpdatedVisited, UpdatedResult} = dfs(NextNode, N, K, NewVisited, AccResult),

                % After the recursive call returns, append the current digit to the result list.
                % This builds the result in reverse order, which will be reversed at the end.
                {UpdatedVisited, [DigitChar | UpdatedResult]}
        end
    end, {Visited, ResultAcc}, lists:seq(0, K - 1)).