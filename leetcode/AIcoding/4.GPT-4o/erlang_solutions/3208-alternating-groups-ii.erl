-module(solution).
-export([alternateGroups/1]).

alternateGroups(List) ->
    alternateGroups(List, true, []).

alternateGroups([], _, Acc) -> 
    lists:reverse(Acc);
alternateGroups([H | T], true, Acc) -> 
    alternateGroups(T, false, [H | Acc]);
alternateGroups([H | T], false, Acc) -> 
    alternateGroups(T, true, [H * -1 | Acc]).