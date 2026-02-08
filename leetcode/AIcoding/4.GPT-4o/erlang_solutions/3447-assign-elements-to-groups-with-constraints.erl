-module(solution).
-export([can_assign/2]).

can_assign(N, constraints) ->
    Groups = lists:duplicate(N, []),
    case assign_groups(constraints, Groups) of
        {ok, _} -> true;
        _ -> false
    end.

assign_groups([], Groups) -> {ok, Groups};
assign_groups([{A, B} | Rest], Groups) ->
    case assign_group(A, B, Groups) of
        {ok, NewGroups} -> assign_groups(Rest, NewGroups);
        _ -> {error, no_assignment}
    end.

assign_group(A, B, Groups) ->
    GroupA = lists:nth(A + 1, Groups),
    GroupB = lists:nth(B + 1, Groups),
    case {GroupA, GroupB} of
        {[], []} -> 
            NewGroups = lists:replace(A + 1, [A], Groups),
            NewGroups1 = lists:replace(B + 1, [B], NewGroups),
            {ok, NewGroups1};
        {[], _} -> 
            NewGroups = lists:replace(A + 1, [A | GroupB], Groups),
            {ok, NewGroups};
        {_, []} -> 
            NewGroups = lists:replace(B + 1, [B | GroupA], Groups),
            {ok, NewGroups};
        {GroupA, GroupB} -> 
            if 
                GroupA =:= GroupB -> {error, conflict}; 
                true -> {ok, Groups} 
            end
    end.