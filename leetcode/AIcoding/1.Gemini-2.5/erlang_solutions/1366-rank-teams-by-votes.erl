-module(solution).
-export([rank_teams/1]).

-spec rank_teams(Votes :: [string()]) -> string().
rank_teams(Votes) ->
    % Get the number of positions (which is also the number of teams)
    NumPositions = length(hd(Votes)),

    % Get the list of all team characters
    Teams = string:to_list(hd(Votes)),

    % Initialize vote counts for all teams to a list of zeros
    % Example: #{'A' => [0,0,0], 'B' => [0,0,0], 'C' => [0,0,0]}
    InitialVoteMap = maps:from_list([{Team, lists:duplicate(NumPositions, 0)} || Team <- Teams]),

    % Process all votes to populate the vote map
    FinalVoteMap = lists:foldl(
        fun(VoteString, AccVoteMap) ->
            % Convert vote string to a list of characters and zip with their 0-indexed positions
            % Example: "ABC" -> [{65,0}, {66,1}, {67,2}]
            VoteCharsWithPositions = lists:zip(string:to_list(VoteString), lists:seq(0, NumPositions - 1)),

            % Update vote counts for each team in the current vote string
            lists:foldl(
                fun({TeamChar, Position}, CurrentVoteMap) ->
                    OldCounts = maps:get(TeamChar, CurrentVoteMap),
                    % lists:nth and lists:replace_nth are 1-indexed, so use Position + 1
                    UpdatedCount = lists:nth(Position + 1, OldCounts) + 1,
                    UpdatedCountsList = lists:replace_nth(Position + 1, UpdatedCount, OldCounts),
                    maps:put(TeamChar, UpdatedCountsList, CurrentVoteMap)
                end,
                AccVoteMap,
                VoteCharsWithPositions
            )
        end,
        InitialVoteMap,
        Votes
    ),

    % Convert the final vote map to a list of {Team, Counts} tuples
    TeamCountsList = maps:to_list(FinalVoteMap),

    % Sort teams based on the custom comparison logic
    SortedTeams = lists:sort(fun({T1, C1}, {T2, C2}) -> compare_team_counts(C1, C2, T1, T2) end, TeamCountsList),

    % Extract team characters from the sorted list and join them into a string
    string:from_list([Team || {Team, _} <- SortedTeams]).

compare_team_counts(Counts1, Counts2, Team1, Team2) ->
    case compare_lists_recursively(Counts1, Counts2) of
        gt -> true;  % Counts1 is greater than Counts2, so Team1 ranks higher
        lt -> false; % Counts2 is greater than Counts1, so Team2 ranks higher
        eq -> Team1 < Team2 % All counts are equal, sort alphabetically by team name
    end.

compare_lists_recursively([], []) -> eq;
compare_lists_recursively([V1 | Rest1], [V2 | Rest2]) ->
    if
        V1 > V2 -> gt;
        V1 < V2 -> lt;
        true -> compare_lists_recursively(Rest1, Rest2)
    end.