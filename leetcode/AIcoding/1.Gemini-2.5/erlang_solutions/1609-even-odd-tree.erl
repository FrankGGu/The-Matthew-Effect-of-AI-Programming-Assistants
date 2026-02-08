-module(solution).
-export([isEvenOddTree/1]).

-record(node, {val, left, right}).

isEvenOddTree(nil) -> true;
isEvenOddTree(Root) ->
    % Queue: a queue of {Node, Level} tuples
    % Start with the root at level 0
    Queue = queue:from_list([{Root, 0}]),
    % Call the BFS helper with initial state
    % CurrentLevel: The level we are currently processing
    % PrevValOnCurrentLevel: The value of the previous node encountered on the CurrentLevel
    %                        Initialized to nil to signify no previous node.
    bfs(Queue, 0, nil).

bfs(Queue, _CurrentLevel, _PrevValOnCurrentLevel) when queue:is_empty(Queue) ->
    true; % All nodes processed, all conditions met
bfs(Queue, CurrentLevel, PrevValOnCurrentLevel) ->
    {{value, {Node, Level}}, RestQueue} = queue:out(Queue),
    Val = Node#node.val,

    % If we are on a new level, reset PrevValOnCurrentLevel
    ActualPrevVal = if Level == CurrentLevel -> PrevValOnCurrentLevel;
                       true -> nil
                    end,

    % Check the current node's value against the rules
    case check_node_value(Level, Val, ActualPrevVal) of
        true ->
            % Enqueue children for the next level
            NewQueue = RestQueue,
            NewQueue1 = if Node#node.left =/= nil -> queue:in({Node#node.left, Level + 1}, NewQueue); true -> NewQueue end,
            NewQueue2 = if Node#node.right =/= nil -> queue:in({Node#node.right, Level + 1}, NewQueue1); true -> NewQueue1 end,

            % Continue BFS with updated state (tail-recursive call)
            bfs(NewQueue2, Level, Val); % Update CurrentLevel and PrevValOnCurrentLevel
        false ->
            false % Condition failed
    end.

check_node_value(Level, CurrentVal, PrevValOnSameLevel) ->
    % 1. Check odd/even property
    IsOddLevel = (Level rem 2 == 1), % True if level is 1, 3, 5... (odd-indexed levels)
    IsCurrentValEven = (CurrentVal rem 2 == 0), % True if value is even

    % Level 0, 2, 4... (even-indexed levels) must have odd values
    % Level 1, 3, 5... (odd-indexed levels) must have even values
    OddEvenCheck =
        case IsOddLevel of
            true -> % Odd-indexed level (e.g., Level 1, 3, ...)
                IsCurrentValEven; % Value must be even
            false -> % Even-indexed level (e.g., Level 0, 2, ...)
                not IsCurrentValEven % Value must be odd
        end,

    if not OddEvenCheck ->
        false;
    true ->
        % 2. Check strict order property
        case PrevValOnSameLevel of
            nil -> % This is the first node encountered on this level
                true; % No previous value to compare with
            _ ->
                case IsOddLevel of
                    true -> % Odd-indexed level: strictly decreasing
                        CurrentVal < PrevValOnSameLevel;
                    false -> % Even-indexed level: strictly increasing
                        CurrentVal > PrevValOnSameLevel
                end
        end
    end.