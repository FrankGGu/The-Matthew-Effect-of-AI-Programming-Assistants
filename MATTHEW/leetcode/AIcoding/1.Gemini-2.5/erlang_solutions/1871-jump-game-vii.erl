-module(solution).
-export([can_reach/3]).

-include_lib("stdlib/include/array.hrl").
-include_lib("stdlib/include/queue.hrl").

can_reach(S, MinJump, MaxJump) ->
    N_val = string:len(S),

    % Base case: if the string has only one character, we are already at the target.
    % Problem constraints state s[0] is always '0'.
    % So if N_val == 1, target is 0, we are at 0, so it's reachable.
    if N_val == 1 ->
        true;
    % If the last character is '1', we can never land on it.
    % string:at(S, N_val) gets the character at 0-indexed N_val - 1.
    else if string:at(S, N_val) == $1 ->
        false;
    else ->
        Queue = queue:new(),
        Queue1 = queue:in(0, Queue), % Start at index 0

        % Visited array to keep track of reachable indices.
        % Initialized to false, except for index 0.
        Visited = array:new({size, N_val}, {fill, false}),
        Visited1 = array:set(0, true, Visited),

        % CurrentMaxReach tracks the farthest index we have considered as a potential jump target.
        % This optimizes the inner loop to avoid re-scanning already processed ranges.
        CurrentMaxReach = 0,

        bfs(Queue1, Visited1, CurrentMaxReach, S, N_val, MinJump, MaxJump)
    end.

bfs(Queue, Visited, CurrentMaxReach, S, N, MinJump, MaxJump) ->
    if queue:is_empty(Queue) ->
        false; % No more reachable indices, and target not found
    else
        {value, I, NewQueue} = queue:out(Queue),

        % Calculate the range of indices J we can jump to from I.
        % StartJ: The minimum index we can jump to from I, but also ensures we don't re-check indices
        %         that were already covered by previous BFS iterations (CurrentMaxReach + 1).
        StartJ = erlang:max(I + MinJump, CurrentMaxReach + 1),
        % EndJ: The maximum index we can jump to from I, capped by the string length.
        EndJ = erlang:min(N - 1, I + MaxJump),

        % Iterate through possible jump targets J.
        Result = check_jumps(StartJ, EndJ, N, S, Visited, NewQueue, N - 1),
        case Result of
            true -> true; % Found target
            {UpdatedVisited, UpdatedQueue, MaxJScannedInThisIteration} ->
                % Update CurrentMaxReach to the maximum index scanned so far across all BFS iterations.
                bfs(UpdatedQueue, UpdatedVisited, erlang:max(CurrentMaxReach, MaxJScannedInThisIteration), S, N, MinJump, MaxJump)
        end
    end.

check_jumps(J, EndJ, N, S, Visited, Queue, TargetIndex) when J =< EndJ ->
    % string:at is 1-indexed, so J+1 for 0-indexed J
    if string:at(S, J + 1) == $0 ->
        if J == TargetIndex ->
            true; % Reached the last index
        else if not array:get(J, Visited) ->
            Visited1 = array:set(J, true, Visited),
            Queue1 = queue:in(J, Queue),
            check_jumps(J + 1, EndJ, N, S, Visited1, Queue1, TargetIndex);
        else % J is '0' but already visited
            check_jumps(J + 1, EndJ, N, S, Visited, Queue, TargetIndex)
        end;
    else % s[J] == '1'
        check_jumps(J + 1, EndJ, N, S, Visited, Queue, TargetIndex)
    end;
check_jumps(J, EndJ, N, S, Visited, Queue, TargetIndex) when J > EndJ ->
    % Finished checking all J in the current range
    {Visited, Queue, EndJ}. % Return updated Visited, Queue, and the max J considered (EndJ)