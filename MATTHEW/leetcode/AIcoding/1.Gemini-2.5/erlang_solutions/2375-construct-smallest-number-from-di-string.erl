-module(solution).
-export([construct_smallest_number/1]).

construct_smallest_number(Pattern) ->
    N = length(Pattern) + 1,
    ResultAcc = solve_helper(0, N, Pattern, 1, [], []),
    lists:reverse(ResultAcc).

solve_helper(I, N, Pattern, CurrentNum, Stack, ResultAcc) when I < N ->
    % Push CurrentNum onto Stack
    NewStack = [CurrentNum | Stack],
    NewCurrentNum = CurrentNum + 1,

    % Determine if we should pop elements from the stack
    % Condition: end of the number construction (I == N-1)
    % OR the current pattern character indicates an increasing sequence ($I)
    ShouldPop = (I == N - 1) orelse (lists:nth(I + 1, Pattern) == $I),
    % lists:nth is 1-indexed, so for 0-indexed I, we use I+1.
    % The `orelse` short-circuits, preventing `lists:nth` from being called
    % if `I == N-1` (which means `I` is `length(Pattern)` and `lists:nth` would go out of bounds).

    if ShouldPop ->
        % Pop all elements from the stack and prepend them to ResultAcc
        % The stack becomes empty after popping all elements.
        {_EmptyStack, UpdatedResultAcc} = pop_all_from_stack(NewStack, ResultAcc),
        solve_helper(I + 1, N, Pattern, NewCurrentNum, [], UpdatedResultAcc);
    true ->
        % Do not pop, continue with the updated stack
        solve_helper(I + 1, N, Pattern, NewCurrentNum, NewStack, ResultAcc)
    end;
solve_helper(N, N, _Pattern, _CurrentNum, _Stack, ResultAcc) ->
    % Base case: I == N, loop finished. Return the accumulated result.
    ResultAcc.

pop_all_from_stack([], ResultAcc) ->
    {[], ResultAcc};
pop_all_from_stack([H | T], ResultAcc) ->
    pop_all_from_stack(T, [H | ResultAcc]).