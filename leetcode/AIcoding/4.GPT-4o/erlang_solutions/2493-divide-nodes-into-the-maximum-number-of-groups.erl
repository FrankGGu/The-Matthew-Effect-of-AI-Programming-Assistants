-module(solution).
-export([maximum_groups/1]).

maximum_groups(N) ->
    maximum_groups_helper(N, 0, 0).

maximum_groups_helper(N, CurrentGroup, Total) when Total + CurrentGroup + 1 =< N ->
    maximum_groups_helper(N, CurrentGroup + 1, Total + CurrentGroup + 1);
maximum_groups_helper(_, _, Total) ->
    Total.