-module(solution).
-export([smallest_sufficient_team/2]).

smallest_sufficient_team(Req_skills, People) ->
    SkillMap = maps:from_list([{Skill, I} || {I, Skill} <- lists:zip(lists:seq(0, length(Req_skills) - 1, Req_skills)]),
    Target = (1 bsl length(Req_skills)) - 1,
    PeopleSkills = lists:map(fun(PersonSkills) ->
        lists:foldl(fun(Skill, Acc) ->
            case maps:get(Skill, SkillMap, undefined) of
                undefined -> Acc;
                Index -> Acc bor (1 bsl Index)
            end
        end, 0, PersonSkills)
    end, People),
    {DP, _} = lists:foldl(fun({PersonMask, PersonIndex}, {DP, Index}) ->
        NewDP = maps:fold(fun(Mask, Team, Acc) ->
            NewMask = Mask bor PersonMask,
            case maps:find(NewMask, Acc) of
                {ok, ExistingTeam} when length(ExistingTeam) =< length(Team) + 1 -> Acc;
                _ -> maps:put(NewMask, [PersonIndex | Team], Acc)
            end
        end, DP, DP),
        {NewDP, Index + 1}
    end, {maps:from_list([{0, []}]), 0}, lists:zip(PeopleSkills, lists:seq(0, length(PeopleSkills) - 1))),
    lists:reverse(maps:get(Target, DP, [])).