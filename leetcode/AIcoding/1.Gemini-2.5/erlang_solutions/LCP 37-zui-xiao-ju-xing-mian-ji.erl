-module(solution).
-export([largestRectangleArea/1]).

largestRectangleArea(Heights) ->
    N = length(Heights),

    % Append a 0 to the heights list to ensure all bars on the stack are processed.
    % This simplifies the logic by not needing a separate post-loop processing step.
    ExtendedHeights = Heights ++ [0],
    ExtendedN = N + 1,

    % Convert list to tuple for O(1) element access, as Erlang lists are slow for random access.
    HeightsTuple = list_to_tuple(ExtendedHeights),

    % State for foldl: {MaxArea, Stack}
    % Stack stores indices of bars in increasing order of height.
    {MaxArea, _FinalStack} = lists:foldl(
        fun(I, {CurrentMaxArea, Stack}) ->
            % Erlang tuples are 1-indexed, so we use I + 1
            CurrentHeight = element(I + 1, HeightsTuple), 

            % Pop elements from the stack while the height of the bar at the stack top
            % is greater than the current bar's height.
            % For each popped bar, calculate the area it forms.
            {NewMaxArea, NewStack} = pop_and_calculate_area(CurrentMaxArea, Stack, CurrentHeight, I, HeightsTuple),

            % Push the current bar's index onto the stack.
            {NewMaxArea, [I | NewStack]}
        end,
        {0, []}, % Initial state: MaxArea = 0, Stack = empty
        lists:seq(0, ExtendedN - 1) % Iterate through indices from 0 to ExtendedN - 1
    ),
    MaxArea.

pop_and_calculate_area(MaxArea, [], _CurrentHeight, _CurrentIndex, _HeightsTuple) ->
    % If stack is empty, nothing to pop.
    {MaxArea, []};
pop_and_calculate_area(MaxArea, [StackTopIndex | RestStack], CurrentHeight, CurrentIndex, HeightsTuple) ->
    % Get the height of the bar at the top of the stack.
    StackTopHeight = element(StackTopIndex + 1, HeightsTuple),

    if
        StackTopHeight > CurrentHeight ->
            % If the stack top bar is taller than the current bar, it means
            % the stack top bar's right boundary is CurrentIndex - 1.
            % Its left boundary is determined by the new stack top (or 0 if stack becomes empty).
            Width = case RestStack of
                        [] -> CurrentIndex; % If stack becomes empty, width is from 0 to CurrentIndex - 1
                        [NextStackTopIndex | _] -> CurrentIndex - NextStackTopIndex - 1
                    end,
            Area = StackTopHeight * Width,
            NewMaxArea = max(MaxArea, Area),

            % Recursively call to continue popping if necessary.
            pop_and_calculate_area(NewMaxArea, RestStack, CurrentHeight, CurrentIndex, HeightsTuple);
        true ->
            % If the stack top bar is not taller, we stop popping.
            % The stack remains unchanged from this point for the current CurrentHeight.
            {MaxArea, [StackTopIndex | RestStack]}
    end.