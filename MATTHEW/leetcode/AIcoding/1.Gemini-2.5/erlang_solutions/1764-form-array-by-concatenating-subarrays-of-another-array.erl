-module(solution).
-export([can_choose/2]).

can_choose(Groups, Nums) ->
    can_choose_recursive(Groups, Nums).

can_choose_recursive([], _Nums) ->
    true;
can_choose_recursive([Group | RestGroups], Nums) ->
    LengthGroup = length(Group),
    find_group_and_recurse_optimized(Nums, Group, RestGroups, LengthGroup).

find_group_and_recurse_optimized(NumsTail, Group, RestGroups, LengthGroup) ->
    if length(NumsTail) < LengthGroup ->
        false;
    true ->
        if lists:prefix(Group, NumsTail) ->
            RemainingNums = lists:nthtail(LengthGroup, NumsTail),
            can_choose_recursive(RestGroups, RemainingNums);
        true ->
            find_group_and_recurse_optimized(tl(NumsTail), Group, RestGroups, LengthGroup)
        end
    end.