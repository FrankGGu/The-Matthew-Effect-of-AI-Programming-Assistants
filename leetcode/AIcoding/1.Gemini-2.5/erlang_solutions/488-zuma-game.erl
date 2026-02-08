-module(solution).
-export([findMinStep/2]).

-define(INFINITY, 1000000).

findMinStep(BoardStr, HandStr) ->
    Board = string:to_list(BoardStr),
    HandMap = hand_to_map(string:to_list(HandStr)),

    % Perform an initial reduction of the board before starting the search.
    % This ensures the starting state is always in its most reduced form.
    InitialBoard = reduce(Board),

    % Call the recursive solver with an empty memoization table.
    % The solver returns a tuple {MinSteps, UpdatedMemo}.
    {MinSteps, _FinalMemo} = solve(InitialBoard, HandMap, #{}),

    % If the minimum steps found is still infinity, it means it's impossible to clear the board.
    if MinSteps >= ?INFINITY -> -1;
    else -> MinSteps
    end.

hand_to_map(HandList) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, HandList).

solve(Board, HandMap, Memo) ->
    % Check if this state (Board, HandMap) has already been computed.
    case maps:find({Board, HandMap}, Memo) of
        {ok, Result} -> 
            {Result, Memo}; % Return the cached result and the current (unchanged) memo table.
        _ ->
            % If the state is not cached, compute the result.
            {Result, UpdatedMemo} = 
                if Board == [] ->
                    {0, Memo}; % Base case: Board is cleared, 0 additional balls needed.
                else
                    Min = ?INFINITY,
                    CurrentMemo = Memo, % Start with the memo table passed to this call.

                    % Get the unique colors of balls currently in hand.
                    HandColors = maps:keys(HandMap),

                    % Iterate through each unique color ball available in hand.
                    % We use lists:foldl to accumulate the minimum steps and update the memo table.
                    {MinForThisLevel, FinalMemoForThisLevel} = lists:foldl(fun(Color, {AccMin, AccMemo}) ->
                        Count = maps:get(Color, HandMap, 0),
                        if Count > 0 ->
                            % If there are balls of this color, decrement its count for the next state.
                            NewHandMap = maps:update_with(Color, fun(C) -> C - 1 end, HandMap),

                            % Iterate through all possible insertion positions for the chosen ball.
                            % A ball can be inserted before the first ball (Pos=0),
                            % between any two balls, or after the last ball (Pos=length(Board)).
                            {PosMin, PosMemo} = lists:foldl(fun(Pos, {InnerAccMin, InnerAccMemo}) ->
                                NewBoard = insert_ball(Board, Color, Pos),
                                % After insertion, reduce the board to its simplest form.
                                ReducedBoard = reduce(NewBoard),
                                % Recursively solve for the new reduced board state.
                                {Steps, RecMemo} = solve(ReducedBoard, NewHandMap, InnerAccMemo),
                                % Update the minimum steps and pass the updated memo table.
                                {min(InnerAccMin, 1 + Steps), RecMemo}
                            end, {AccMin, AccMemo}, lists:seq(0, length(Board))),
                            {PosMin, PosMemo}
                        else
                            % No balls of this color left, continue with the current minimum and memo.
                            {AccMin, AccMemo}
                        end
                    end, {Min, CurrentMemo}, HandColors),
                    {MinForThisLevel, FinalMemoForThisLevel}
                end,
            % Store the computed result for the current state in the memo table before returning.
            {Result, maps:put({Board, HandMap}, Result, UpdatedMemo)}
    end.

insert_ball(Board, Ball, Pos) ->
    {Before, After} = lists:split(Pos, Board),
    Before ++ [Ball] ++ After.

reduce(Board) ->
    reduce_loop_stack(Board, []).

reduce_loop_stack([], Stack) -> 
    lists:reverse(Stack); % When the board is fully processed, reverse the stack to get the final board order.
reduce_loop_stack([H|T], Stack) ->
    case Stack of
        [H, H | Rest] -> % If the current ball H forms 3 consecutive with the top two stack elements (H, H, H)
            % This means a sequence of 3 or more H's has been formed.
            % We "pop" the two H's from the stack (by using Rest) and effectively skip the current H.
            % This removes the entire sequence of H's.
            reduce_loop_stack(T, Rest);
        _ -> % Otherwise, the current ball H does not form 3 consecutive with the top of the stack.
            % Push H onto the stack and continue processing the rest of the board.
            reduce_loop_stack(T, [H|Stack])
    end.