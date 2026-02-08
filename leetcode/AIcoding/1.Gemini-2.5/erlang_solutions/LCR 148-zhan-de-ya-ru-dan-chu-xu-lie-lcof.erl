-module(solution).
-export([is_valid_sequence/2]).

is_valid_sequence(Pushed, Popped) ->
    process_pushes(Pushed, Popped, []).

process_pushes([], PoppedRemaining, Stack) ->
    % All elements from Pushed have been processed.
    % Now, check if the remaining stack can be entirely emptied by the remaining Popped sequence.
    can_empty_stack(PoppedRemaining, Stack);
process_pushes([PushHead|PushTail], PoppedCurrent, StackCurrent) ->
    % Push the current element onto the stack.
    StackAfterPush = [PushHead|StackCurrent],

    % After pushing, try to pop as many matching elements as possible from the stack
    % based on the `PoppedCurrent` sequence.
    {PoppedAfterPop, StackAfterPop} = pop_matching(PoppedCurrent, StackAfterPush),

    % Continue processing with the remaining pushed elements,
    % the updated popped sequence, and the updated stack.
    process_pushes(PushTail, PoppedAfterPop, StackAfterPop).

pop_matching(Popped, Stack) ->
    % Recursively pop elements from the stack if they match the head of Popped.
    case {Popped, Stack} of
        {[], _} ->
            % No more elements to pop from the `Popped` sequence.
            {Popped, Stack};
        {_, []} ->
            % Stack is empty, cannot pop further.
            {Popped, Stack};
        {[PoppedHead|PoppedTail], [StackHead|StackTail]} when PoppedHead == StackHead ->
            % Match found: the top of the stack matches the next element to be popped.
            % Pop from both and continue checking.
            pop_matching(PoppedTail, StackTail);
        _ ->
            % No match found or other non-matching case, stop popping.
            {Popped, Stack}
    end.

can_empty_stack(PoppedRemaining, Stack) ->
    case {PoppedRemaining, Stack} of
        {[], []} ->
            % Both are empty, meaning all elements were correctly pushed and popped.
            true;
        {_, []} ->
            % `PoppedRemaining` still has elements but the stack is empty, cannot pop more.
            false;
        {[], _} ->
            % Stack still has elements but `PoppedRemaining` is empty, cannot pop more.
            false;
        {[PoppedHead|PoppedTail], [StackHead|StackTail]} when PoppedHead == StackHead ->
            % Match found, continue checking the rest.
            can_empty_stack(PoppedTail, StackTail);
        _ ->
            % Mismatch: the top of the stack does not match the next element to be popped.
            false
    end.