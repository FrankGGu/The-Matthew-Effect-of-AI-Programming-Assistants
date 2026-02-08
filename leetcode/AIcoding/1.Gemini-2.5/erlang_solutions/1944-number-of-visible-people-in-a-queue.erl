-module(solution).
-export([can_see_persons_count/1]).

can_see_persons_count(HeightsList) ->
    N = length(HeightsList),
    Heights = array:from_list(HeightsList), % Convert list to array for O(1) access

    % The stack stores indices [Idx | StackTail], where Idx is the top (closest to the current person).
    % Heights[Idx] will be in decreasing order in the stack.
    % This means if Stack = [J1, J2, ...], then Heights[J1] > Heights[J2] > ...

    % The result list (AccAns) is built by prepending elements.
    % When iterating from N-1 down to 0, if we prepend ans[Idx] to AccAns,
    % the final AccAns will be in the order [ans_0, ans_1, ..., ans_{N-1}].
    can_see_persons_count_recursive(N - 1, Heights, [], []).

can_see_persons_count_recursive(-1, _Heights, _Stack, AccAns) ->
    AccAns; % AccAns is already in the correct order
can_see_persons_count_recursive(Idx, Heights, Stack, AccAns) ->
    HeightI = array:get(Idx, Heights), % Array is 0-indexed

    Count = 0,
    {NewStack, FinalCount} = process_stack(HeightI, Stack, Heights, Count),

    % Push current index onto stack for the next iteration.
    % This maintains the decreasing height property of the stack.
    NewStackWithCurrent = [Idx | NewStack],

    can_see_persons_count_recursive(Idx - 1, Heights, NewStackWithCurrent, [FinalCount | AccAns]).

process_stack(HeightI, Stack, Heights, CurrentCount) ->
    case Stack of
        [] ->
            {[], CurrentCount}; % Stack is empty, no more people to the right to see.
        [Jdx | RestStack] ->
            HeightJ = array:get(Jdx, Heights), % Height of the person at the top of the stack.
            if
                HeightJ < HeightI ->
                    % Person J is shorter than person I. Person I can see person J.
                    % Pop J from the stack and continue checking the rest of the stack.
                    process_stack(HeightI, RestStack, Heights, CurrentCount + 1);
                true -> % HeightJ >= HeightI
                    % Person J is taller or equal to person I. Person I can see person J.
                    % Person J blocks the view of any people further to the right (deeper in the stack).
                    % So, stop processing the stack and return J and the rest of the stack.
                    {[Jdx | RestStack], CurrentCount + 1}
            end
    end.