-module(solution).
-export([find_champion/1]).

find_champion(Grid) ->
    N = length(Grid),
    find_champion_recursive(0, Grid, N).

find_champion_recursive(TeamIndex, Grid, N) when TeamIndex < N ->
    case is_champion(TeamIndex, Grid, N) of
        true -> TeamIndex;
        false -> find_champion_recursive(TeamIndex + 1, Grid, N)
    end.

is_champion(TeamIndex, Grid, N) ->
    check_other_teams(0, TeamIndex, Grid, N).

check_other_teams(OtherTeamIndex, TeamIndex, Grid, N) when OtherTeamIndex < N ->
    if
        OtherTeamIndex == TeamIndex ->
            check_other_teams(OtherTeamIndex + 1, TeamIndex, Grid, N);
        true ->
            TeamRow = lists:nth(TeamIndex + 1, Grid),
            Result = lists:nth(OtherTeamIndex + 1, TeamRow),
            if
                Result == 1 ->
                    check_other_teams(OtherTeamIndex + 1, TeamIndex, Grid, N);
                true ->
                    false
            end
    end;
check_other_teams(N, _TeamIndex, _Grid, N) ->
    true.