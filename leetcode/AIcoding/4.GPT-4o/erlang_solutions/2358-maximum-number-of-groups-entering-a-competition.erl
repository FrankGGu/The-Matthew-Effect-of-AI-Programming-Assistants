-module(solution).
-export([max_groups/1]).

max_groups(people) ->
    max_groups_helper(people, 0, 0).

max_groups_helper(People, Groups, Sum) when Sum + Groups + 1 =< People ->
    max_groups_helper(People, Groups + 1, Sum + Groups + 1);
max_groups_helper(_, Groups, _) ->
    Groups.