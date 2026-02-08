-module(solution).
-export([smallest_sufficient_team/2]).

smallest_sufficient_team(ReqSkills, People) ->
    % 1. Map skill names to integer indices
    SkillMap = maps:from_list(lists:zip(ReqSkills, lists:seq(0, length(ReqSkills) - 1))),
    NumSkills = length(ReqSkills),
    AllSkillsMask = (1 bsl NumSkills) - 1,

    % 2. Convert each person's skills into a bitmask
    PersonSkillsMasks = array:from_list(
        lists:map(fun(PersonSkills) ->
            lists:foldl(fun(Skill, Mask) ->
                case maps:find(Skill, SkillMap) of
                    {ok, Idx} -> Mask bor (1 bsl Idx);
                    error -> Mask % Ignore skills not in ReqSkills
                end
            end, 0, PersonSkills)
        end, People)
    ),

    NumPeople = length(People),

    % Initialize DP array
    % dp[mask] = list of person indices
    % InitialDpValue is a placeholder for 'infinity', a list guaranteed to be longer than any valid team.
    % The maximum possible team size is NumPeople. So, a list of NumPeople + 1 elements works.
    InitialDpValue = lists:duplicate(NumPeople + 1, -1), 

    % Dp array stores the smallest team for each skill mask.
    % It's initialized with 'infinity' for all masks except 0.
    Dp = array:new([{size, 1 bsl NumSkills}, {default, InitialDpValue}]),
    Dp1 = array:set(0, [], Dp), % dp[0] = empty list (no people needed for no skills)

    % Iterate through each person
    FinalDp = lists:foldl(fun(PersonIdx, CurrentDp) ->
        PSkills = array:get(PersonIdx, PersonSkillsMasks), % O(1) access

        % Iterate through masks from AllSkillsMask down to 0
        % This order is crucial to ensure that when we update dp[NewMask],
        % dp[Mask] refers to the state *before* considering the current person PersonIdx
        % for the Mask itself.
        lists:foldl(fun(Mask, InnerDp) ->
            Team = array:get(Mask, InnerDp),

            % Check if 'Team' is a valid team (not the 'infinity' placeholder)
            if length(Team) =< NumPeople -> 
                NewMask = Mask bor PSkills,
                NewTeam = Team ++ [PersonIdx],

                CurrentBestTeam = array:get(NewMask, InnerDp),

                % If the NewTeam is smaller than the CurrentBestTeam for NewMask
                if length(NewTeam) < length(CurrentBestTeam) ->
                    array:set(NewMask, NewTeam, InnerDp);
                true ->
                    InnerDp % No improvement
                end;
            true ->
                InnerDp % No valid team for 'Mask', so skip
            end
        end, CurrentDp, lists:seq(AllSkillsMask, 0, -1))
    end, Dp1, lists:seq(0, NumPeople - 1)),

    % The final answer is the team for the AllSkillsMask
    array:get(AllSkillsMask, FinalDp).