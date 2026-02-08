-module(solution).
-export([bestTeamWithNoConflicts/2]).

-include_lib("array/include/array.hrl").

bestTeamWithNoConflicts(Scores, Ages) ->
    Players = lists:zip(Ages, Scores),

    % Sort players primarily by age in ascending order.
    % If ages are equal, sort by score in ascending order.
    % This ensures that when we iterate, if player J comes before player I,
    % then AgeJ <= AgeI. If AgeJ < AgeI, we must have ScoreJ <= ScoreI to avoid conflict.
    % If AgeJ = AgeI, then ScoreJ <= ScoreI due to secondary sort, and there's no age conflict.
    SortedPlayers = lists:sort(fun({A1, S1}, {A2, S2}) ->
                                     if A1 < A2 -> true;
                                        A1 > A2 -> false;
                                        true -> S1 =< S2 % Tie-break by score ascending
                                     end
                             end, Players),

    N_players = length(SortedPlayers),

    % Handle empty input case
    if N_players == 0 ->
        0;
    true ->
        % Convert sorted players list to an array for efficient indexed access (O(1))
        PlayersArray = array:from_list(SortedPlayers),

        % Initialize DP array. dp[i] will store the maximum score of a valid team
        % that includes SortedPlayers[i] as its last (or "oldest" in the sorted sense) member.
        % Initially, each player can form a team by themselves, so dp[i] = ScoreI.
        DPArray0 = array:new([{size, N_players}]),
        InitialDPArray = array:foldl(fun(Idx, {_, Score}, Acc) -> array:set(Idx, Score, Acc) end,
                                     DPArray0,
                                     PlayersArray),

        % Iterate through players (indexed by I) to compute DP values
        FinalDPArray = lists:foldl(
            fun(I, CurrentDPArray) ->
                {_AgeI, ScoreI} = array:get(I, PlayersArray),

                % Calculate MaxScoreForI: the maximum score for a team ending with player I.
                % This is Player I's score plus the max DP value of any preceding player J,
                % provided player J's score is less than or equal to player I's score.
                MaxScoreForI = lists:foldl(
                    fun(J, AccMax) ->
                        {_AgeJ, ScoreJ} = array:get(J, PlayersArray),

                        % Condition for no conflict: ScoreJ must be less than or equal to ScoreI.
                        % This handles both AgeJ < AgeI and AgeJ = AgeI cases due to sorting.
                        if ScoreJ =< ScoreI ->
                               max(AccMax, array:get(J, CurrentDPArray) + ScoreI);
                           true ->
                               AccMax
                        end
                    end,
                    ScoreI, % Base case: Player I alone forms a team with score ScoreI
                    lists:seq(0, I-1) % Iterate through all players before I
                ),
                array:set(I, MaxScoreForI, CurrentDPArray)
            end,
            InitialDPArray, % Start with DP array initialized with individual player scores
            lists:seq(0, N_players-1) % Iterate for each player's index
        ),

        % The final answer is the maximum value found in the DP array
        array:foldl(fun(_Idx, Val, MaxSoFar) -> max(Val, MaxSoFar) end, 0, FinalDPArray)
    end.