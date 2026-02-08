-spec findTheWinner(Skills :: [integer()], K :: integer()) -> integer().
findTheWinner(Skills, K) ->
    N = length(Skills),
    if
        K >= N ->
            % If K is greater than or equal to the number of players,
            % the player with the maximum skill will eventually reach the front
            % and win all subsequent games.
            lists:max(Skills);
        true ->
            % Initial state: The first player in the list is the current winner,
            % with 0 consecutive wins. The rest of the players form the queue.
            % Queue is represented as {FrontList, BackListReversed} for O(1) amortized operations.
            solve(hd(Skills), 0, {tl(Skills), []}, K)
    end.

get_next_player_and_queue({[NextPlayer | Rest], BackListReversed}) ->
    {NextPlayer, {Rest, BackListReversed}};
get_next_player_and_queue({[], BackListReversed}) ->
    % Front list is empty, reverse the back list to become the new front.
    get_next_player_and_queue({lists:reverse(BackListReversed), []}).

add_to_back(Player, {FrontList, BackListReversed}) ->
    {FrontList, [Player | BackListReversed]}.

solve(CurrentWinner, CurrentStreak, Queue, K) ->
    {NextPlayer, UpdatedQueueAfterPop} = get_next_player_and_queue(Queue),

    if
        CurrentWinner > NextPlayer ->
            % CurrentWinner wins the game
            NewStreak = CurrentStreak + 1,
            if
                NewStreak == K ->
                    CurrentWinner; % Found the winner
                true ->
                    % CurrentWinner stays at the front, NextPlayer goes to the end of the queue
                    solve(CurrentWinner, NewStreak, add_to_back(NextPlayer, UpdatedQueueAfterPop), K)
            end;
        true ->
            % NextPlayer wins the game
            % NextPlayer becomes the new CurrentWinner, their streak starts at 1.
            % The old CurrentWinner goes to the end of the queue.
            if
                K == 1 ->
                    % If K is 1, the new winner immediately satisfies the condition
                    NextPlayer;
                true ->
                    solve(NextPlayer, 1, add_to_back(CurrentWinner, UpdatedQueueAfterPop), K)
            end
    end.