-module(assign_elements).
-export([solve/1]).

solve(Constraints) ->
    N = maps:get(n, Constraints),
    GroupSizes = maps:get(groupSizes, Constraints),
    BeforeItems = maps:get(beforeItems, Constraints),

    solve_helper(N, GroupSizes, BeforeItems).

solve_helper(N, GroupSizes, BeforeItems) ->
    try_assignment(N, GroupSizes, BeforeItems, []).

try_assignment(N, GroupSizes, BeforeItems, Assignment) ->
    if length(Assignment) == N ->
        {ok, Assignment};
    true ->
        Index = length(Assignment),
        PossibleGroups = possible_groups(Index, GroupSizes),
        try_groups(Index, PossibleGroups, GroupSizes, BeforeItems, Assignment, N)
    end.

try_groups(_Index, [], _GroupSizes, _BeforeItems, _Assignment, _N) ->
    false;
try_groups(Index, [Group | Rest], GroupSizes, BeforeItems, Assignment, N) ->
    if is_valid_assignment(Index, Group, GroupSizes, BeforeItems, Assignment) ->
        NewGroupSizes = maps:update(Group, maps:get(Group, GroupSizes) - 1, GroupSizes),
        NewAssignment = Assignment ++ [Group],
        case try_assignment(N, NewGroupSizes, BeforeItems, NewAssignment) of
            {ok, Result} ->
                {ok, Result};
            false ->
                try_groups(Index, Rest, GroupSizes, BeforeItems, Assignment, N)
        end;
    true ->
        try_groups(Index, Rest, GroupSizes, BeforeItems, Assignment, N)
end.

is_valid_assignment(Index, Group, GroupSizes, BeforeItems, Assignment) ->
    (maps:get(Group, GroupSizes) > 0) andalso
    is_before_items_satisfied(Index, Group, BeforeItems, Assignment).

is_before_items_satisfied(Index, Group, BeforeItems, Assignment) ->
    Before = lists:nth(Index + 1, BeforeItems),
    lists:all(fun(BeforeItem) ->
                      BeforeItem == -1 orelse
                      (lists:nth(BeforeItem + 1, Assignment) == Group)
              end, Before).

possible_groups(Index, GroupSizes) ->
    maps:keys(maps:filter(fun(_K, V) -> V > 0 end, GroupSizes)).